import Foundation
import Combine

// MARK: - Native progress engine (replaces the web LessonEngine + localStorage)

final class ProgressStore: ObservableObject {
    static let shared = ProgressStore()

    struct CourseProgress: Codable {
        var completed: [Int] = []
        var inProgressNode: Int? = nil
        var inProgressScreen: Int = 0
        var testedOutUnits: [Int]? = nil
        var testOutReviewNodes: [String: [Int]]? = nil
        var testOutRetryUnits: [Int]? = nil
    }

    private struct Snapshot: Codable {
        var courses: [String: CourseProgress] = [:]
        var currentCourse: String = Game.defaultCourseId
        var userName: String = "Guest"
        var reminderOn: Bool = true

        var xp: Int = 0
        var treats: Int = 0
        var streak: Int = 0
        var lastLessonDate: String? = nil
        var activeDates: Set<String> = []
        var hearts: Int = 25
        var heartAnchor: Date? = nil

        var completed: [Int]? = nil
        var inProgressNode: Int? = nil
        var inProgressScreen: Int? = nil
    }

    static let maxHearts = 25
    static let heartRegenSeconds: TimeInterval = 3600

    private var s: Snapshot { didSet { persist() } }
    private static let key = "moko_progress_v1"

    private init() {
        if let data = UserDefaults.standard.data(forKey: Self.key),
           let decoded = try? JSONDecoder().decode(Snapshot.self, from: data) {
            s = decoded
        } else {
            s = Snapshot()
        }
        s.completed = nil; s.inProgressNode = nil; s.inProgressScreen = nil
        keepOnlyKnownCourses()
        if s.hearts == 5, s.heartAnchor == nil {
            s.hearts = Self.maxHearts
        }
    }

    // MARK: Course selection

    var currentCourse: String { s.currentCourse }

    func switchCourse(_ id: String) {
        guard Game.courses.contains(where: { $0.id == id }) else { return }
        s.currentCourse = id
    }

    private func keepOnlyKnownCourses() {
        var snapshot = s
        let known = Set(Game.courses.map(\.id))
        snapshot.courses = snapshot.courses.filter { known.contains($0.key) }
        if !known.contains(snapshot.currentCourse) { snapshot.currentCourse = Game.defaultCourseId }
        s = snapshot
    }

    private var cur: CourseProgress {
        get { s.courses[s.currentCourse] ?? CourseProgress() }
        set {
            var value = newValue
            s.courses[s.currentCourse] = value
        }
    }

    func lessonsDone(course: String) -> Int { s.courses[course]?.completed.count ?? 0 }

    var totalLessonsDone: Int { s.courses.values.reduce(0) { $0 + $1.completed.count } }

    private func persist() {
        if let data = try? JSONEncoder().encode(s) {
            UserDefaults.standard.set(data, forKey: Self.key)
        }
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

    var hearts: Int { reconcileHearts(); return s.hearts }

    var secondsUntilNextHeart: Int? {
        reconcileHearts()
        guard s.hearts < Self.maxHearts, let anchor = s.heartAnchor else { return nil }
        let remaining = anchor.addingTimeInterval(Self.heartRegenSeconds).timeIntervalSinceNow
        return max(0, Int(ceil(remaining)))
    }

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

    @discardableResult
    func useHeart() -> Bool {
        reconcileHearts()
        guard s.hearts > 0 else { return false }
        let wasFull = s.hearts == Self.maxHearts
        s.hearts -= 1
        if wasFull { s.heartAnchor = Date() }
        return true
    }

    // MARK: Monetization (prototype — no real payments; local mock state only)

    @discardableResult
    func spendTreats(_ amount: Int) -> Bool {
        guard s.treats >= amount else { return false }
        s.treats -= amount
        return true
    }

    @discardableResult
    func refillHearts(cost: Int) -> Bool {
        guard s.hearts < Self.maxHearts else { return false }
        guard spendTreats(cost) else { return false }
        s.hearts = Self.maxHearts
        s.heartAnchor = nil
        return true
    }

    func grantBonusHearts(_ n: Int) {
        reconcileHearts()
        s.hearts = min(Self.maxHearts, s.hearts + n)
        if s.hearts >= Self.maxHearts { s.heartAnchor = nil }
    }

    var inProgressNode: Int? { cur.inProgressNode }

    func resumeScreen(node: Int) -> Int {
        cur.inProgressNode == node ? cur.inProgressScreen : 0
    }

    func hasInProgress(node: Int) -> Bool { cur.inProgressNode == node }

    // MARK: Writes

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
            s.treats += 1
            let group = unitNodes.isEmpty ? [node] : unitNodes
            if group.allSatisfy({ c.completed.contains($0) }) {
                s.treats += 3
            }
            let yesterday = Self.dateString(Calendar.current.date(byAdding: .day, value: -1, to: Date()) ?? Date())
            if s.lastLessonDate == today {
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

    func weekActivity() -> [(label: String, active: Bool, isToday: Bool)] {
        var cal = Calendar.current
        cal.firstWeekday = 2
        let now = Date()
        let startOfWeek = cal.dateInterval(of: .weekOfYear, for: now)?.start ?? now
        let labels = ["Mo", "Tu", "We", "Th", "Fr", "Sa", "Su"]
        return (0..<7).map { i in
            let day = cal.date(byAdding: .day, value: i, to: startOfWeek) ?? now
            let key = Self.dateString(day)
            return (labels[i], s.activeDates.contains(key), cal.isDateInToday(day))
        }
    }

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

    func reset() {
        s = Snapshot()
    }

    func unlockAll(totalNodes: Int) {
        var c = cur; c.completed = Array(1...max(1, totalNodes)); cur = c
    }

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
