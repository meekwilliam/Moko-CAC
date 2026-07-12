import Foundation
import Combine

// MARK: - Native progress engine (replaces the web LessonEngine + localStorage)
// Single source of truth for completion / XP / streak / mid-lesson resume,
// persisted in UserDefaults. Mirrors LessonEngine.recordCompletion exactly.
//
// XP, treats, streak, and hearts are GLOBAL — they carry across every course,
// like a single Duolingo profile. Only which lessons are completed (and any
// in-progress lesson) is tracked per course, since node numbers overlap
// between courses (node 1 in Skincare and node 1 in Finance are different
// lessons and must unlock independently).

final class ProgressStore: ObservableObject {
    static let shared = ProgressStore()

    // Per-course unlock/resume state only.
    struct CourseProgress: Codable {
        var completed: [Int] = []
        var inProgressNode: Int? = nil
        var inProgressScreen: Int = 0
        var testedOutUnits: [Int]? = nil
        var testOutReviewNodes: [String: [Int]]? = nil
        var testOutRetryUnits: [Int]? = nil
        var contentVersion: Int? = nil
    }

    private struct Snapshot: Codable {
        var courses: [String: CourseProgress] = [:]
        var currentCourse: String = "skincare"
        var userName: String = "Guest"
        var reminderOn: Bool = true

        // Global stats — shared across every course.
        var xp: Int = 0
        var treats: Int = 0
        var streak: Int = 0
        var lastLessonDate: String? = nil
        // Calendar dates ("yyyy-MM-dd") that counted toward the streak — powers
        // the weekly Mo–Su row on the streak celebration screen.
        var activeDates: Set<String> = []
        // Hearts are global too: original question answers cost 1; regen 1/hour.
        var hearts: Int = 25
        var heartAnchor: Date? = nil
        // Prototype monetization: mock "unlimited hearts" subscription state.
        var unlimitedHearts: Bool = false

        // Legacy flat fields (pre-multi-course) — used once to migrate.
        var completed: [Int]? = nil
        var inProgressNode: Int? = nil
        var inProgressScreen: Int? = nil
    }

    static let maxHearts = 25
    static let heartRegenSeconds: TimeInterval = 3600   // 1 hour

    private var s: Snapshot { didSet { persist() } }
    private static let key = "moko_progress_v1"

    // Cloud-sync hooks (wired by SyncService / ViewController; nil when local-only).
    /// Fires after any local change so the syncer can push to the cloud.
    var onChange: (() -> Void)?
    /// Fires after a cloud snapshot is adopted so the UI (path/profile) refreshes.
    var onExternalReplace: (() -> Void)?
    /// While true, local persists don't trigger `onChange` (used when adopting a
    /// pulled cloud snapshot, so we don't immediately push it straight back).
    private var suppressChange = false

    private init() {
        if let data = UserDefaults.standard.data(forKey: Self.key),
           let decoded = try? JSONDecoder().decode(Snapshot.self, from: data) {
            s = decoded
        } else {
            s = Snapshot()
        }
        // One-time migration: fold any legacy flat progress into the skincare course.
        if s.courses.isEmpty, let done = s.completed {
            s.courses["skincare"] = CourseProgress(
                completed: done, inProgressNode: s.inProgressNode,
                inProgressScreen: s.inProgressScreen ?? 0)
        }
        s.completed = nil; s.inProgressNode = nil; s.inProgressScreen = nil
        migrateCondensedOrderFlowProgressIfNeeded()
        if !s.unlimitedHearts, s.hearts == 5, s.heartAnchor == nil {
            s.hearts = Self.maxHearts
        }
    }

    // MARK: Course selection

    var currentCourse: String { s.currentCourse }

    func switchCourse(_ id: String) { s.currentCourse = id }

    /// The current course's unlock/resume bucket (created on first access).
    private var cur: CourseProgress {
        get { s.courses[s.currentCourse] ?? CourseProgress() }
        set {
            var value = newValue
            if s.currentCourse == "orderflow" { value.contentVersion = 2 }
            s.courses[s.currentCourse] = value
        }
    }

    /// Version 2 condenses Order Flow from 111 to 77 nodes. Preserve the user's
    /// approximate progress by unit instead of letting old node numbers point at
    /// unrelated new lessons.
    private func migrateCondensedOrderFlowProgressIfNeeded() {
        guard var progress = s.courses["orderflow"], progress.contentVersion != 2 else { return }
        let oldCounts = [5, 8, 11, 13, 15, 14, 12, 14, 10, 9]
        let newCounts = [5, 7, 7, 8, 10, 9, 8, 9, 7, 7]
        var oldStart = 1
        var newStart = 1
        var remapped: [Int] = []
        for unit in oldCounts.indices {
            let oldRange = oldStart..<(oldStart + oldCounts[unit])
            let completedInUnit = progress.completed.filter { oldRange.contains($0) }.count
            let testedOut = progress.testedOutUnits?.contains(unit) == true
            var newCompleted = testedOut ? newCounts[unit]
                : Int(floor(Double(completedInUnit) / Double(oldCounts[unit]) * Double(newCounts[unit])))
            if unit == 9 && testedOut { newCompleted = max(0, newCompleted - 1) }
            remapped.append(contentsOf: newStart..<(newStart + newCompleted))
            if let active = progress.inProgressNode, oldRange.contains(active) {
                let fraction = Double(active - oldStart) / Double(max(1, oldCounts[unit] - 1))
                progress.inProgressNode = newStart + Int(round(fraction * Double(max(0, newCounts[unit] - 1))))
            }
            oldStart += oldCounts[unit]
            newStart += newCounts[unit]
        }
        progress.completed = Array(Set(remapped)).sorted()
        progress.contentVersion = 2
        s.courses["orderflow"] = progress
    }

    /// Completed-lesson count for any single course (drives the switcher's progress text).
    func lessonsDone(course: String) -> Int { s.courses[course]?.completed.count ?? 0 }

    /// Total completed lessons across every course.
    var totalLessonsDone: Int { s.courses.values.reduce(0) { $0 + $1.completed.count } }

    private func persist() {
        if let data = try? JSONEncoder().encode(s) {
            UserDefaults.standard.set(data, forKey: Self.key)
        }
        if !suppressChange { onChange?() }
    }

    // MARK: Cloud sync (portable snapshot in/out — see Backend/SyncService)

    /// The full state as portable JSON (what gets stored in the cloud).
    func currentSnapshotData() -> Data? { try? JSONEncoder().encode(s) }

    /// Adopt a snapshot pulled from the cloud, replacing local state. Persists
    /// locally but does NOT re-trigger a push, then asks the UI to refresh.
    func replaceSnapshot(with data: Data) {
        guard let decoded = try? JSONDecoder().decode(Snapshot.self, from: data) else { return }
        suppressChange = true
        s = decoded
        suppressChange = false
        onExternalReplace?()
    }

    // MARK: Reads

    var completed: [Int] { cur.completed }
    var testedOutUnits: [Int] { cur.testedOutUnits ?? [] }
    var recommendedReviewNodes: [Int] { Array(Set((cur.testOutReviewNodes ?? [:]).values.flatMap { $0 })).sorted() }
    var testOutBlockedUnits: [Int] { (cur.testOutReviewNodes ?? [:]).compactMap { $0.value.isEmpty ? nil : Int($0.key) } }
    var testOutRetryUnits: [Int] { cur.testOutRetryUnits ?? [] }
    var xp: Int { s.xp }
    var treats: Int { s.treats }
    var streak: Int { s.streak }
    var userName: String { s.userName }
    var reminderOn: Bool { s.reminderOn }
    var lessonsDone: Int { totalLessonsDone }
    let energy: Int = 25

    // MARK: Hearts

    /// Current hearts, after applying any regeneration that has accrued.
    var hearts: Int { reconcileHearts(); return s.hearts }

    /// Prototype "Super" subscription: unlimited hearts, no gating or regen countdown.
    var isUnlimitedHearts: Bool { s.unlimitedHearts }

    /// Whether the user has a heart to spend on an original question answer.
    var canAnswerQuestion: Bool { isUnlimitedHearts || hearts > 0 }

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

    /// Spend a heart when an original question is answered. Starts the regen
    /// clock if we were at full. Returns false if there were none to spend.
    @discardableResult
    func useHeart() -> Bool {
        guard !isUnlimitedHearts else { return true }   // Super: never spend hearts
        reconcileHearts()
        guard s.hearts > 0 else { return false }
        let wasFull = s.hearts == Self.maxHearts
        s.hearts -= 1
        if wasFull { s.heartAnchor = Date() }
        return true
    }

    // MARK: Monetization (prototype — no real payments; local mock state only)

    /// Spend treats. Returns false (no-op) if the balance is insufficient.
    @discardableResult
    func spendTreats(_ amount: Int) -> Bool {
        guard s.treats >= amount else { return false }
        s.treats -= amount
        return true
    }

    /// Refill to full hearts for a treat cost. Returns false if treats were insufficient.
    @discardableResult
    func refillHearts(cost: Int) -> Bool {
        guard s.hearts < Self.maxHearts else { return false }   // nothing to refill
        guard spendTreats(cost) else { return false }
        s.hearts = Self.maxHearts
        s.heartAnchor = nil
        return true
    }

    /// Grant bonus hearts (e.g. inviting a friend), capped at the max.
    func grantBonusHearts(_ n: Int) {
        reconcileHearts()
        s.hearts = min(Self.maxHearts, s.hearts + n)
        if s.hearts >= Self.maxHearts { s.heartAnchor = nil }
    }

    /// Toggle the mock "Super" unlimited-hearts subscription.
    func setUnlimitedHearts(_ on: Bool) { s.unlimitedHearts = on }

    /// The node with saved mid-lesson progress (drives the "CONTINUE" tooltip).
    /// Note: screen 0 still counts as "in progress" so a learner who opens and
    /// exits before answering can resume from the beginning.
    var inProgressNode: Int? { cur.inProgressNode }

    func resumeScreen(node: Int) -> Int {
        cur.inProgressNode == node ? cur.inProgressScreen : 0
    }

    /// Whether this lesson already has a saved attempt, so it can resume from
    /// the last saved screen on re-open.
    func hasInProgress(node: Int) -> Bool { cur.inProgressNode == node }

    // MARK: Writes

    /// Mirrors LessonEngine.recordCompletion: +100 for a new node (with streak
    /// bookkeeping), +25 for a replay. Completion state is per-course; XP,
    /// treats, and streak are global.
    /// `unitNodes` — every node number sharing this node's unit (any size),
    /// supplied by the caller since ProgressStore has no knowledge of course
    /// content structure. Defaults to just the node itself if not given.
    /// Returns whether this call is the first completion TODAY that extends
    /// the streak — the caller uses this to decide whether to show the
    /// streak celebration screen (once per day, not on every lesson).
    @discardableResult
    func recordCompletion(node: Int, unitNodes: [Int] = []) -> Bool {
        var c = cur
        let isNew = !c.completed.contains(node)
        let today = Self.dateString(Date())
        var extendedStreakToday = false
        if !isNew {
            s.xp += 25
        } else {
            c.completed.append(node)
            s.xp += 100
            // Treats: 1 per new lesson, plus 3 more when this finishes the
            // whole unit (every node in that unit is now complete).
            s.treats += 1
            let group = unitNodes.isEmpty ? [node] : unitNodes
            if group.allSatisfy({ c.completed.contains($0) }) {
                s.treats += 3
            }
            let yesterday = Self.dateString(Calendar.current.date(byAdding: .day, value: -1, to: Date()) ?? Date())
            if s.lastLessonDate == today {
                // already counted today
            } else {
                extendedStreakToday = true
                if s.lastLessonDate == yesterday {
                    s.streak += 1
                } else {
                    s.streak = 1
                }
            }
            s.lastLessonDate = today
            s.activeDates.insert(today)
        }
        if var reviews = c.testOutReviewNodes {
            for key in Array(reviews.keys) { reviews[key]?.removeAll { $0 == node } }
            c.testOutReviewNodes = reviews
        }
        cur = c
        return extendedStreakToday
    }

    func recordTestOut(units: [Int], completedNodes: [Int]) {
        var c = cur
        for node in completedNodes where !c.completed.contains(node) { c.completed.append(node) }
        var tested = c.testedOutUnits ?? []
        for unit in units where !tested.contains(unit) { tested.append(unit) }
        c.testedOutUnits = tested
        var reviews = c.testOutReviewNodes ?? [:]
        for unit in units { reviews.removeValue(forKey: String(unit)) }
        c.testOutReviewNodes = reviews
        c.testOutRetryUnits = (c.testOutRetryUnits ?? []).filter { !units.contains($0) }
        // A Test Out is a single assessment reward, not the sum of every
        // skipped lesson's XP. This prevents jump-ahead farming.
        s.xp += 100
        cur = c
    }

    func recordTestOutFailure(unit: Int, recommendedNodes: [Int]) {
        var c = cur
        var reviews = c.testOutReviewNodes ?? [:]
        reviews[String(unit)] = Array(Set(recommendedNodes)).sorted()
        c.testOutReviewNodes = reviews
        var retryUnits = c.testOutRetryUnits ?? []
        if !retryUnits.contains(unit) { retryUnits.append(unit) }
        c.testOutRetryUnits = retryUnits
        cur = c
    }

    /// This calendar week (Monday–Sunday), each day flagged whether it counted
    /// toward the streak, for the celebration screen's weekly row.
    func weekActivity() -> [(label: String, active: Bool, isToday: Bool)] {
        var cal = Calendar.current
        cal.firstWeekday = 2   // Monday
        let now = Date()
        let startOfWeek = cal.dateInterval(of: .weekOfYear, for: now)?.start ?? now
        let labels = ["Mo", "Tu", "We", "Th", "Fr", "Sa", "Su"]
        return (0..<7).map { i in
            let day = cal.date(byAdding: .day, value: i, to: startOfWeek) ?? now
            let key = Self.dateString(day)
            return (labels[i], s.activeDates.contains(key), cal.isDateInToday(day))
        }
    }

    /// Testing helper: force the streak up by 1 and mark today active, bypassing
    /// the "only once per real day" rule in recordCompletion — lets the streak
    /// celebration screen be triggered repeatedly to check the animation.
    @discardableResult
    func debugBumpStreak() -> Int {
        s.streak += 1
        let today = Self.dateString(Date())
        s.lastLessonDate = today
        s.activeDates.insert(today)
        return s.streak
    }

    func saveInProgress(node: Int, screen: Int) {
        var c = cur; c.inProgressNode = node; c.inProgressScreen = screen; cur = c
    }

    func clearInProgress() {
        var c = cur; c.inProgressNode = nil; c.inProgressScreen = 0; cur = c
    }

    func setReminder(_ on: Bool) { s.reminderOn = on }
    func setUserName(_ name: String) { s.userName = name }

    func reset() {
        s = Snapshot()
    }

    /// Testing helper: mark every node complete so all lessons are unlocked.
    func unlockAll(totalNodes: Int) {
        var c = cur; c.completed = Array(1...max(1, totalNodes)); cur = c
    }

    /// Testing helper: top up treats so you can freely test refills/shop flows.
    func grantTestTreats(_ amount: Int = 9999) {
        s.treats += amount
    }

    private static func dateString(_ date: Date) -> String {
        let f = DateFormatter()
        f.calendar = Calendar.current
        f.locale = Locale(identifier: "en_US_POSIX")
        f.dateFormat = "yyyy-MM-dd"
        return f.string(from: date)
    }
}
