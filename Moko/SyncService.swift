import Foundation

// MARK: - Progress sync coordinator
// Orchestrates cloud sync through the Backend seam (no vendor SDK here).
//   • On launch / sign-in: pull the user's cloud snapshot. If it exists, adopt
//     it; if not (fresh account), push the current local snapshot up.
//   • Afterwards: every local change debounce-pushes to the cloud.
// Local-first is preserved — if there's no signed-in user or the network
// fails, the app keeps working off UserDefaults and syncs on the next change.

final class SyncService {
    static let shared = SyncService()

    private var uid: String?
    private var pushTask: Task<Void, Never>?

    /// Called at launch: if a session was restored, start syncing.
    func bootstrap() {
        Task {
            if let user = await Backend.auth.restore() {
                await activate(uid: user.id)
            }
        }
    }

    /// Called right after a successful sign-in from onboarding.
    func userDidSignIn(_ user: BackendUser) {
        Task { await activate(uid: user.id) }
    }

    private func activate(uid: String) async {
        self.uid = uid
        do {
            if let cloud = try await Backend.store.loadSnapshot(userID: uid) {
                await MainActor.run { ProgressStore.shared.replaceSnapshot(with: cloud) }
            } else if let local = await MainActor.run(body: { ProgressStore.shared.currentSnapshotData() }) {
                try await Backend.store.saveSnapshot(userID: uid, json: local)
            }
        } catch {
            // Offline / not configured — stay local; the change hook will retry.
        }
        await MainActor.run {
            ProgressStore.shared.onChange = { [weak self] in self?.schedulePush() }
        }
    }

    /// Debounced push so a burst of local writes (finishing a lesson) sends once.
    private func schedulePush() {
        guard uid != nil else { return }
        pushTask?.cancel()
        pushTask = Task { [weak self] in
            try? await Task.sleep(nanoseconds: 800_000_000)
            guard !Task.isCancelled, let self, let uid = self.uid else { return }
            let data = await MainActor.run { ProgressStore.shared.currentSnapshotData() }
            if let data { try? await Backend.store.saveSnapshot(userID: uid, json: data) }
        }
    }
}
