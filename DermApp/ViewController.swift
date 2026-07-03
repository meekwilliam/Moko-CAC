import UIKit
import SwiftUI

// Fully native host: builds the SwiftUI AppRouter and drives it from the native
// GameData (bundled content) + ProgressStore (UserDefaults). No WebView.

class ViewController: UIViewController {
    private var appRouter = AppRouter()
    private var themeManager = ThemeManager()
    private var routerHost: UIHostingController<AppRouterView>?

    private var progress: ProgressStore { ProgressStore.shared }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Let button press-states fire instantly inside SwiftUI ScrollViews.
        UIScrollView.appearance().delaysContentTouches = false
        view.backgroundColor = UIColor(red: 0x0F/255.0, green: 0x17/255.0, blue: 0x2A/255.0, alpha: 1)

        setupAppRouter()
        presentNativePath()   // boot straight onto the path (home tab)

        // Hold the branded loading screen for a short beat, then fade to the path.
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.3) { [weak self] in
            self?.appRouter.showSplash = false
        }
    }

    // MARK: - Router setup + callbacks

    private func setupAppRouter() {
        let host = UIHostingController(rootView: AppRouterView(router: appRouter, theme: themeManager))
        host.view.backgroundColor = .clear
        host.view.frame = view.bounds
        host.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addChild(host)
        view.addSubview(host.view)
        host.didMove(toParent: self)
        routerHost = host

        appRouter.onOpenLesson = { [weak self] node in self?.openLesson(node: node) }

        appRouter.onSaveLessonProgress = { [weak self] screen in
            guard let node = self?.appRouter.currentLesson?.node else { return }
            self?.progress.saveInProgress(node: node, screen: screen)
        }

        appRouter.onCompleteLesson = { [weak self] node in
            guard let self = self else { return }
            self.progress.recordCompletion(node: node)
            self.progress.useHeart()          // a completed lesson costs one heart
            self.progress.clearInProgress()
            self.refreshPathState()
            self.syncHearts()
            withAnimation(.spring(response: 0.42, dampingFraction: 0.86)) {
                self.appRouter.selectedTab = .home
                self.appRouter.currentScreen = .main
            }
        }

        appRouter.onExitLesson = { [weak self] in
            self?.refreshPathState()   // pull in saved in-progress so the tooltip shows "CONTINUE"
            withAnimation(.spring(response: 0.42, dampingFraction: 0.86)) { self?.appRouter.currentScreen = .main }
        }

        appRouter.onToggleReminders = { [weak self] on in self?.progress.setReminder(on) }
        appRouter.onClearData = { [weak self] in self?.confirmClearData() }
        appRouter.requestLegalDoc = { [weak self] kind in self?.presentLegal(kind: kind) }
        appRouter.onRequestPath = { [weak self] in self?.presentNativePath() }
        appRouter.onRequestProfile = { [weak self] in self?.presentNativeProfile() }
        appRouter.onOpenHearts = { [weak self] in self?.openHearts() }
        appRouter.onUnlockAll = { [weak self] in
            guard let self = self else { return }
            self.progress.unlockAll(totalNodes: Game.totalNodes)
            self.refreshPathState()
            Haptics.impact(.medium)
        }
        syncHearts()
    }

    // MARK: - Hearts

    /// Push the current heart count + regen countdown into the router for the UI.
    private func syncHearts() {
        appRouter.hearts = progress.hearts
        appRouter.secondsUntilNextHeart = progress.secondsUntilNextHeart
        appRouter.pathStore?.hearts = progress.hearts
    }

    private func openHearts() {
        syncHearts()
        if case .hearts = appRouter.currentScreen { return }   // already showing → just synced
        withAnimation(.spring(response: 0.42, dampingFraction: 0.86)) {
            appRouter.currentScreen = .hearts
        }
    }

    // MARK: - Native data builders

    private func makePathPayload() -> PathPayload {
        PathPayload(
            stats: PathStats(xp: progress.xp, treats: progress.treats, streak: progress.streak,
                             hearts: progress.hearts, energy: progress.energy),
            completed: progress.completed,
            sections: Game.data.sections,
            nodes: Game.data.nodes,
            inProgressNode: progress.inProgressNode
        )
    }

    // MARK: - Screens

    private func presentNativePath() {
        if let store = appRouter.pathStore {
            store.update(completed: progress.completed, xp: progress.xp, treats: progress.treats,
                         streak: progress.streak, inProgressNode: progress.inProgressNode)
        } else {
            appRouter.pathStore = PathStore(payload: makePathPayload())
        }
        syncHearts()
        withAnimation(.easeInOut(duration: 0.28)) {
            appRouter.selectedTab = .home
            appRouter.currentScreen = .main
        }
    }

    private func refreshPathState() {
        appRouter.pathStore?.update(completed: progress.completed, xp: progress.xp, treats: progress.treats,
                                    streak: progress.streak, inProgressNode: progress.inProgressNode)
    }

    private func openLesson(node: Int) {
        guard let lesson = Game.lesson(node: node) else { return }
        // Out of hearts → can't start a lesson; show the hearts screen instead.
        // (Resuming an in-progress lesson is always allowed.)
        let resumeAt = progress.resumeScreen(node: node)
        if resumeAt == 0 && !progress.canStartLesson {
            openHearts()
            return
        }
        appRouter.currentLessonIsReplay = progress.completed.contains(node)
        presentNativeLesson(lesson: lesson, startIndex: resumeAt)
    }

    private func presentNativeLesson(lesson: Lesson, startIndex: Int) {
        appRouter.currentLesson = lesson
        appRouter.currentLessonStartIndex = startIndex
        withAnimation(.spring(response: 0.42, dampingFraction: 0.86)) { appRouter.currentScreen = .lesson }
    }

    private func presentNativeProfile() {
        let payload = ProfilePayload(userName: progress.userName, xp: progress.xp,
                                     streak: progress.streak, lessons: progress.lessonsDone,
                                     reminderOn: progress.reminderOn, badges: [])
        appRouter.profileStore = ProfileStore(payload: payload)
        withAnimation(.easeInOut(duration: 0.28)) {
            appRouter.selectedTab = .profile
            appRouter.currentScreen = .main
        }
    }

    private func presentLegal(kind: String) {
        guard let doc = Game.legalDoc(kind) else { return }
        withAnimation(.easeInOut(duration: 0.28)) { appRouter.currentScreen = .legal(doc) }
    }

    private func confirmClearData() {
        let alert = UIAlertController(title: nil, message: "Reset all progress?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Reset", style: .destructive) { [weak self] _ in
            self?.progress.reset()
            self?.refreshPathState()
            withAnimation(.easeInOut(duration: 0.28)) {
                self?.appRouter.selectedTab = .home
                self?.appRouter.currentScreen = .main
            }
        })
        present(alert, animated: true)
    }
}
