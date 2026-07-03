import Foundation
import Combine

// MARK: - Native progress engine (replaces the web LessonEngine + localStorage)
// Single source of truth for completion / XP / streak / mid-lesson resume,
// persisted in UserDefaults. Mirrors LessonEngine.recordCompletion exactly.

final class ProgressStore: ObservableObject {
    static let shared = ProgressStore()

    private struct Snapshot: Codable {
        var completed: [Int] = []
        var xp: Int = 0
        var treats: Int = 0
        var streak: Int = 0
        var lastLessonDate: String? = nil
        var inProgressNode: Int? = nil
        var inProgressScreen: Int = 0
        var userName: String = "Guest"
        var reminderOn: Bool = true
        // Hearts: a lesson costs 1; regenerate 1/hour up to `maxHearts`.
        var hearts: Int = 5
        var heartAnchor: Date? = nil   // when the current regen hour started
    }

    static let maxHearts = 5
    static let heartRegenSeconds: TimeInterval = 3600   // 1 hour

    private var s: Snapshot { didSet { persist() } }
    private static let key = "glowo_progress_v1"

    private init() {
        if let data = UserDefaults.standard.data(forKey: Self.key),
           let decoded = try? JSONDecoder().decode(Snapshot.self, from: data) {
            s = decoded
        } else {
            s = Snapshot()
        }
    }

    private func persist() {
        if let data = try? JSONEncoder().encode(s) {
            UserDefaults.standard.set(data, forKey: Self.key)
        }
    }

    // MARK: Reads

    var completed: [Int] { s.completed }
    var xp: Int { s.xp }
    var treats: Int { s.treats }
    var streak: Int { s.streak }
    var userName: String { s.userName }
    var reminderOn: Bool { s.reminderOn }
    var lessonsDone: Int { s.completed.count }
    let energy: Int = 25

    // MARK: Hearts

    /// Current hearts, after applying any regeneration that has accrued.
    var hearts: Int { reconcileHearts(); return s.hearts }

    /// Whether the user has a heart to spend on a lesson.
    var canStartLesson: Bool { hearts > 0 }

    /// Seconds until the next heart regenerates, or nil when already full.
    var secondsUntilNextHeart: Int? {
        reconcileHearts()
        guard s.hearts < Self.maxHearts, let anchor = s.heartAnchor else { return nil }
        let remaining = anchor.addingTimeInterval(Self.heartRegenSeconds).timeIntervalSinceNow
        return max(0, Int(ceil(remaining)))
    }

    /// Fold any elapsed regen time into the stored heart count.
    private func reconcileHearts() {
        guard s.hearts < Self.maxHearts else {
            if s.heartAnchor != nil { s.heartAnchor = nil }
            return
        }
        guard let anchor = s.heartAnchor else { return }
        let now = Date()
        var gained = 0
        var next = anchor.addingTimeInterval(Self.heartRegenSeconds)
        while s.hearts + gained < Self.maxHearts && now >= next {
            gained += 1
            next = next.addingTimeInterval(Self.heartRegenSeconds)
        }
        guard gained > 0 else { return }
        s.hearts = min(Self.maxHearts, s.hearts + gained)
        s.heartAnchor = (s.hearts >= Self.maxHearts) ? nil : next.addingTimeInterval(-Self.heartRegenSeconds)
    }

    /// Spend a heart on a completed lesson. Starts the regen clock if we were
    /// at full. Returns false if there were none to spend.
    @discardableResult
    func useHeart() -> Bool {
        reconcileHearts()
        guard s.hearts > 0 else { return false }
        let wasFull = s.hearts == Self.maxHearts
        s.hearts -= 1
        if wasFull { s.heartAnchor = Date() }
        return true
    }

    /// The node with saved mid-lesson progress (drives the "CONTINUE" tooltip).
    var inProgressNode: Int? { (s.inProgressScreen > 0) ? s.inProgressNode : nil }

    func resumeScreen(node: Int) -> Int {
        (s.inProgressNode == node && s.inProgressScreen > 0) ? s.inProgressScreen : 0
    }

    // MARK: Writes

    /// Mirrors LessonEngine.recordCompletion: +100 for a new node (with streak
    /// bookkeeping), +25 for a replay.
    func recordCompletion(node: Int) {
        let isNew = !s.completed.contains(node)
        let today = Self.dateString(Date())
        if !isNew {
            s.xp += 25
        } else {
            s.completed.append(node)
            s.xp += 100
            // Treats: 1 per new lesson, plus 3 more when this finishes a unit
            // (all 5 nodes of the section now complete).
            s.treats += 1
            let unitStart = ((node - 1) / 5) * 5 + 1
            let unitNodes = Array(unitStart...(unitStart + 4))
            if unitNodes.allSatisfy({ s.completed.contains($0) }) {
                s.treats += 3
            }
            let yesterday = Self.dateString(Calendar.current.date(byAdding: .day, value: -1, to: Date()) ?? Date())
            if s.lastLessonDate == today {
                // already counted today
            } else if s.lastLessonDate == yesterday {
                s.streak += 1
            } else {
                s.streak = 1
            }
            s.lastLessonDate = today
        }
    }

    func saveInProgress(node: Int, screen: Int) {
        s.inProgressNode = node
        s.inProgressScreen = screen
    }

    func clearInProgress() {
        s.inProgressNode = nil
        s.inProgressScreen = 0
    }

    func setReminder(_ on: Bool) { s.reminderOn = on }
    func setUserName(_ name: String) { s.userName = name }

    func reset() {
        s = Snapshot()
    }

    /// Testing helper: mark every node complete so all lessons are unlocked.
    func unlockAll(totalNodes: Int) {
        s.completed = Array(1...max(1, totalNodes))
    }

    private static func dateString(_ date: Date) -> String {
        let f = DateFormatter()
        f.calendar = Calendar.current
        f.locale = Locale(identifier: "en_US_POSIX")
        f.dateFormat = "yyyy-MM-dd"
        return f.string(from: date)
    }
}
