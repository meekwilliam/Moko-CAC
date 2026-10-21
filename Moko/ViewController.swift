import UIKit
import SwiftUI

// Fully native host: builds the SwiftUI AppRouter and drives it from the native
// GameData (bundled content) + ProgressStore (UserDefaults). No WebView.

class ViewController: UIViewController {
    private var appRouter = AppRouter()
    private var themeManager = ThemeManager()
    private var routerHost: UIHostingController<AppRouterView>?
    private var activeTestOutUnit: Int?
    private var activeTestOutIsJump = false

    private var progress: ProgressStore { ProgressStore.shared }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Let button press-states fire instantly inside SwiftUI ScrollViews.
        UIScrollView.appearance().delaysContentTouches = false
        view.backgroundColor = UIColor(red: 0x0E/255.0, green: 0x16/255.0, blue: 0x1A/255.0, alpha: 1)

        setupAppRouter()
        presentNativePath()
        if shouldShowOnboardingOnLaunch {
            appRouter.currentScreen = .onboarding
        }

        // When a cloud snapshot is pulled in (sign-in / launch restore), refresh
        // the derived UI stores so the path/profile reflect the synced state.
        progress.onExternalReplace = { [weak self] in
            guard let self = self else { return }
            self.refreshPathState(); self.syncHearts(); self.syncCourses()
        }
        SyncService.shared.bootstrap()   // resume cloud sync if already signed in

        // Hold the branded loading screen for a short beat, then fade to the path.
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.3) { [weak self] in
            self?.appRouter.showSplash = false
        }
    }

    private var shouldShowOnboardingOnLaunch: Bool {
        !UserDefaults.standard.bool(forKey: "onboarding.completed")
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
        appRouter.onOpenTestOut = { [weak self] unit in self?.openTestOut(unit: unit) }
        appRouter.onCompleteTestOut = { [weak self] correct, total, correctCompetencies, missedCompetencies in
            self?.completeTestOut(correct: correct, total: total, correctCompetencies: correctCompetencies,
                                  missedCompetencies: missedCompetencies)
        }

        appRouter.onSaveLessonProgress = { [weak self] screen in
            guard let node = self?.appRouter.currentLesson?.node else { return }
            self?.progress.saveInProgress(node: node, screen: screen)
        }

        appRouter.onSpendQuestionHeart = { [weak self] in
            guard let self = self else { return false }
            guard self.progress.useHeart() else {
                self.openHearts()
                return false
            }
            self.syncHearts()
            return true
        }

        appRouter.onCompleteLesson = { [weak self] node in
            guard let self = self else { return }
            let extendedStreakToday = self.progress.recordCompletion(node: node, unitNodes: self.unitNodes(forNode: node))
            self.progress.clearInProgress()
            self.refreshPathState()
            self.syncHearts()
            if extendedStreakToday {
                self.appRouter.streakCount = self.progress.streak
                self.appRouter.streakWeek = self.progress.weekActivity()
                withAnimation(.easeOut(duration: 0.22)) {
                    self.appRouter.currentScreen = .streak
                }
            } else {
                withAnimation(.easeOut(duration: 0.22)) {
                    self.appRouter.selectedTab = .home
                    self.appRouter.currentScreen = .main
                }
            }
        }

        appRouter.onExitLesson = { [weak self] in
            self?.refreshPathState()   // pull in saved in-progress so the tooltip shows "CONTINUE"
            withAnimation(.easeOut(duration: 0.22)) { self?.appRouter.currentScreen = .main }
        }

        appRouter.onToggleReminders = { [weak self] on in self?.progress.setReminder(on) }
        appRouter.onClearData = { [weak self] in self?.confirmClearData() }
        appRouter.requestLegalDoc = { [weak self] kind in self?.presentLegal(kind: kind) }
        appRouter.onRequestPath = { [weak self] in self?.presentNativePath() }
        appRouter.onRequestProfile = { [weak self] in self?.presentNativeProfile() }
        appRouter.onOpenHearts = { [weak self] in self?.openHearts() }
        appRouter.onUnlockAll = { [weak self] in
            guard let self = self else { return }
            self.progress.unlockAll(totalNodes: Game.totalNodes(course: self.progress.currentCourse))
            self.refreshPathState()
            Haptics.impact(.medium)
        }
        appRouter.onOpenMechanicsTest = { [weak self] in self?.openMechanicsTestLesson() }
        appRouter.onOpenMultiSignalTest = { [weak self] in self?.openMultiSignalTestLesson() }
        appRouter.onPreviewStreak = { [weak self] in
            guard let self = self else { return }
            // Preview only — doesn't touch real streak/progress data.
            self.appRouter.streakCount = max(1, self.progress.streak)
            self.appRouter.streakWeek = self.progress.weekActivity()
            withAnimation(.spring(response: 0.42, dampingFraction: 0.86)) {
                self.appRouter.currentScreen = .streak
            }
        }
        appRouter.onBumpStreak = { [weak self] in
            guard let self = self else { return }
            let n = self.progress.debugBumpStreak()
            self.refreshPathState()
            self.appRouter.streakCount = n
            self.appRouter.streakWeek = self.progress.weekActivity()
            withAnimation(.spring(response: 0.42, dampingFraction: 0.86)) {
                self.appRouter.currentScreen = .streak
            }
        }
        appRouter.onGrantTestTreats = { [weak self] in
            guard let self = self else { return }
            self.progress.grantTestTreats()
            self.refreshPathState()
            self.syncHearts()
            Haptics.impact(.medium)
        }
        appRouter.onOnboardingFinished = { [weak self] in
            // Never land on the home screen after onboarding — go straight
            // into the first lesson (completing one immediately drives retention).
            self?.openLesson(node: 1)
        }
        appRouter.onOpenCourses = { [weak self] in self?.openCourses() }
        appRouter.onSelectCourse = { [weak self] id in self?.selectCourse(id) }
        appRouter.onRefillHearts = { [weak self] in self?.refillHearts() }
        appRouter.onInviteFriend = { [weak self] in self?.presentInviteFriend() }
        // Old installs may hold a course id that no longer exists (courses were
        // restructured into levels) — fall back to the first level.
        if !Game.courses.contains(where: { $0.id == progress.currentCourse }) {
            progress.switchCourse(Game.defaultCourseId)
        }
        syncHearts()
        syncCourses()
    }

    // MARK: - Hearts monetization (prototype)

    static let heartRefillCost = 50
    static let inviteFriendBonusHearts = 5

    private func refillHearts() {
        if progress.refillHearts(cost: Self.heartRefillCost) {
            Haptics.impact(.medium)
        } else {
            Haptics.rigid()   // not enough treats, or already full
        }
        syncHearts()
    }

    private func presentInviteFriend() {
        let text = "Come learn with me on Moko! 🐶"
        let sheet = UIActivityViewController(activityItems: [text], applicationActivities: nil)
        sheet.completionWithItemsHandler = { [weak self] _, completed, _, _ in
            guard completed, let self = self else { return }
            self.progress.grantBonusHearts(Self.inviteFriendBonusHearts)
            self.syncHearts()
            Haptics.impact(.medium)
        }
        present(sheet, animated: true)
    }

    // MARK: - Courses

    private func syncCourses() {
        appRouter.currentCourseId = progress.currentCourse
        var counts: [String: Int] = [:]
        for c in Game.courses { counts[c.id] = progress.lessonsDone(course: c.id) }
        appRouter.courseLessonsDone = counts
    }

    private func openCourses() {
        guard Game.courses.count > 1 else { return }
        syncCourses()
        if case .courses = appRouter.currentScreen { return }
        withAnimation(.spring(response: 0.42, dampingFraction: 0.86)) {
            appRouter.currentScreen = .courses
        }
    }

    private func selectCourse(_ id: String) {
        progress.switchCourse(id)
        syncCourses()
        Haptics.impact(.medium)
        withAnimation(.spring(response: 0.38, dampingFraction: 0.86)) {
            // Rebuild the path for the new course (different nodes/units) and show it.
            appRouter.pathStore = PathStore(payload: makePathPayload())
            syncHearts()
            appRouter.selectedTab = .home
            appRouter.currentScreen = .main
        }
    }

    // MARK: - Hearts

    /// Push the current heart count + regen countdown into the router for the UI.
    private func syncHearts() {
        appRouter.hearts = progress.hearts
        appRouter.secondsUntilNextHeart = progress.secondsUntilNextHeart
        appRouter.isUnlimitedHearts = progress.isUnlimitedHearts
        appRouter.treats = progress.treats
        appRouter.pathStore?.hearts = progress.hearts
        appRouter.pathStore?.isUnlimitedHearts = progress.isUnlimitedHearts
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
        let course = Game.course(progress.currentCourse)
        return PathPayload(
            stats: PathStats(xp: progress.xp, treats: progress.treats, streak: progress.streak,
                             hearts: progress.hearts, energy: progress.energy),
            completed: progress.completed,
            sections: course.sections,
            nodes: course.nodes,
            inProgressNode: progress.inProgressNode,
            testedOutUnits: progress.testedOutUnits,
            recommendedReviewNodes: progress.recommendedReviewNodes,
            testOutBlockedUnits: progress.testOutBlockedUnits,
            testOutRetryUnits: progress.testOutRetryUnits
        )
    }

    // MARK: - Screens

    private func presentNativePath() {
        if let store = appRouter.pathStore {
            store.update(completed: progress.completed, xp: progress.xp, treats: progress.treats,
                         streak: progress.streak, inProgressNode: progress.inProgressNode,
                         testedOutUnits: progress.testedOutUnits,
                         recommendedReviewNodes: progress.recommendedReviewNodes,
                         testOutBlockedUnits: progress.testOutBlockedUnits,
                         testOutRetryUnits: progress.testOutRetryUnits)
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
                                    streak: progress.streak, inProgressNode: progress.inProgressNode,
                                    testedOutUnits: progress.testedOutUnits,
                                    recommendedReviewNodes: progress.recommendedReviewNodes,
                                    testOutBlockedUnits: progress.testOutBlockedUnits,
                                    testOutRetryUnits: progress.testOutRetryUnits)
    }

    private func openTestOut(unit: Int) {
        let course = Game.course(progress.currentCourse)
        guard let test = course.testOuts?.first(where: { $0.unitIndex == unit }) else { return }
        var screens: [LessonScreen] = []
        let previousNodes = course.nodes.filter { $0.sectionIndex == unit - 1 }.map(\.num)
        let isJump = unit > 0 && !previousNodes.allSatisfy { progress.completed.contains($0) }

        func appendQuestion(from definition: TestOutDefinition, competency: String) {
            let eligibleIds = Set(definition.competencyEligibleQuestionIds?[competency] ?? [])
            let sourceUnits = Set(definition.competencySourceUnits?[competency] ?? [])
            let sourceNodes = Set(definition.competencySourceNodes?[competency] ?? [])
            if let match = definition.questionPool.shuffled().first(where: { candidate in
                candidate.competencyId == competency &&
                (eligibleIds.isEmpty || candidate.questionId.map(eligibleIds.contains) == true) &&
                (sourceUnits.isEmpty || candidate.sourceUnit.map(sourceUnits.contains) == true) &&
                (sourceNodes.isEmpty || candidate.sourceNode.map(sourceNodes.contains) == true) &&
                !screens.contains(where: {
                    $0.id == candidate.id || ($0.type == candidate.type && $0.question == candidate.question)
                })
            }) { screens.append(match) }
        }

        if isJump, let prerequisiteBlueprint = test.jumpPrerequisiteBlueprint,
           let targetBlueprint = test.jumpTargetBlueprint {
            for slot in prerequisiteBlueprint {
                guard let source = course.testOuts?.first(where: { $0.unitIndex == slot.unitIndex }) else { continue }
                appendQuestion(from: source, competency: slot.competencyId)
            }
            for competency in targetBlueprint { appendQuestion(from: test, competency: competency) }
        } else {
            for competency in test.competencyBlueprint ?? [] {
                appendQuestion(from: test, competency: competency)
            }
        }
        let questionCount = isJump ? (test.jumpAheadQuestionCount ?? test.questionCount) : test.questionCount
        let fallbackPools = isJump
            ? (course.testOuts ?? []).filter { $0.unitIndex <= unit }.flatMap(\.questionPool)
            : test.questionPool
        if screens.count < questionCount {
            for screen in fallbackPools.shuffled() where !screens.contains(where: {
                $0.id == screen.id || ($0.type == screen.type && $0.question == screen.question)
            }) {
                screens.append(screen)
                if screens.count == questionCount { break }
            }
        }
        screens = Array(screens.prefix(questionCount)).shuffled()
        guard !screens.isEmpty else { return }
        activeTestOutUnit = unit
        activeTestOutIsJump = isJump
        let lesson = Lesson(node: -(unit + 1), title: "\(isJump ? "JUMP AHEAD" : "TEST OUT"): \(course.sections[unit].title)",
                            celebration: "Assessment complete.", featurePromo: nil,
                            lessonType: "TEST_OUT", screens: screens,
                            assessmentOverallMinimum: isJump ? test.jumpPassingScore : test.passingScore,
                            assessmentPrerequisiteMinimum: isJump ? test.jumpPrerequisiteMinimum : nil,
                            assessmentTargetMinimum: isJump ? test.jumpTargetMinimum : nil,
                            assessmentTargetCompetencies: isJump ? test.jumpTargetBlueprint : nil)
        appRouter.currentLessonIsReplay = false
        appRouter.currentLessonUnitColor = (Color(hex: "#2563EB"), Color(hex: "#B7791F"))
        appRouter.currentLessonBonusEligible = false
        appRouter.currentLessonIsUnitTest = false
        appRouter.isTestLesson = true
        presentNativeLesson(lesson: lesson, startIndex: 0)
    }

    private func completeTestOut(correct: Int, total _: Int, correctCompetencies: [String: Int],
                                 missedCompetencies: [String: Int]) {
        guard let unit = activeTestOutUnit else { return }
        activeTestOutUnit = nil
        let isJump = activeTestOutIsJump
        activeTestOutIsJump = false
        let course = Game.course(progress.currentCourse)
        guard let test = course.testOuts?.first(where: { $0.unitIndex == unit }) else { return }
        let targetCompetencies = Set(test.jumpTargetBlueprint ?? [])
        let targetCorrect = correctCompetencies.filter { targetCompetencies.contains($0.key) }.values.reduce(0, +)
        let prerequisiteCorrect = correctCompetencies.filter { !targetCompetencies.contains($0.key) }.values.reduce(0, +)
        let passed = isJump
            ? correct >= (test.jumpPassingScore ?? test.passingScore) &&
              prerequisiteCorrect >= (test.jumpPrerequisiteMinimum ?? 0) &&
              targetCorrect >= (test.jumpTargetMinimum ?? 0)
            : correct >= test.passingScore
        if passed {
            let testedUnits = isJump ? Array(0...unit) : [unit]
            var nodes = course.nodes.filter { testedUnits.contains($0.sectionIndex) }.map(\.num).sorted()
            // Unit 10's Final Boss remains required for full course mastery.
            if unit == 9, let finalBoss = course.nodes.filter({ $0.sectionIndex == 9 }).map(\.num).max() {
                nodes.removeAll { $0 == finalBoss }
            }
            progress.recordTestOut(units: testedUnits, completedNodes: nodes)
        } else {
            var recommendations: [Int] = []
            let weakCompetencies = missedCompetencies.sorted { $0.value > $1.value }.map(\.key)
            for competency in weakCompetencies {
                guard let definition = course.testOuts?.first(where: { $0.competencyBlueprint?.contains(competency) == true }),
                      let nodes = definition.competencySourceNodes?[competency] else { continue }
                for node in nodes where !progress.completed.contains(node) && !recommendations.contains(node) {
                    recommendations.append(node)
                    if recommendations.count == 3 { break }
                }
                if recommendations.count == 3 { break }
            }
            progress.recordTestOutFailure(unit: unit, recommendedNodes: recommendations)
        }
        appRouter.isTestLesson = false
        refreshPathState()
        withAnimation(.easeInOut(duration: 0.28)) { appRouter.currentScreen = .main }
    }

    private func openLesson(node: Int) {
        guard let lesson = Game.lesson(course: progress.currentCourse, node: node) else { return }
        if !progress.hasInProgress(node: node) {
            progress.saveInProgress(node: node, screen: 0)
        }
        let resumeAt = progress.resumeScreen(node: node)
        appRouter.currentLessonIsReplay = progress.completed.contains(node)
        appRouter.currentLessonUnitColor = unitColor(forNode: node)
        appRouter.currentLessonBonusEligible = isLastNodeInUnit(node)
        appRouter.currentLessonIsUnitTest = isFinalNodeOfUnit(node)
        presentNativeLesson(lesson: lesson, startIndex: resumeAt)
    }

    /// The (main, dark) banner color for whichever unit a node belongs to,
    /// looked up from the course's real section data — works for any unit size.
    private func unitColor(forNode node: Int) -> (main: Color, dark: Color)? {
        let course = Game.course(progress.currentCourse)
        guard let nodeData = course.nodes.first(where: { $0.num == node }),
              let sec = course.sections.first(where: { $0.index == nodeData.sectionIndex }) else {
            return nil
        }
        return (Color(hex: sec.bg), Color(hex: sec.slab))
    }

    /// All node numbers sharing this node's unit — used to detect "finished a
    /// unit" for the treats bonus, regardless of that unit's actual size.
    private func unitNodes(forNode node: Int) -> [Int] {
        let course = Game.course(progress.currentCourse)
        guard let nodeData = course.nodes.first(where: { $0.num == node }) else { return [node] }
        return course.nodes.filter { $0.sectionIndex == nodeData.sectionIndex }.map { $0.num }
    }

    /// Whether completing this node right now would finish its whole unit —
    /// i.e. every other node in the unit is already done. Computed up front
    /// so the reward screen can predict the unit bonus before completion is
    /// actually recorded.
    /// Structurally the unit's last node — its review test. Unlike
    /// `isLastNodeInUnit`, this doesn't depend on what's been completed.
    private func isFinalNodeOfUnit(_ node: Int) -> Bool {
        unitNodes(forNode: node).max() == node
    }

    private func isLastNodeInUnit(_ node: Int) -> Bool {
        let group = unitNodes(forNode: node)
        return group.filter { $0 != node }.allSatisfy { progress.completed.contains($0) }
    }

    /// Debug: opens a synthetic lesson with one screen per question mechanic,
    /// bypassing hearts/progress entirely (isTestLesson skips both on exit).
    private func openMechanicsTestLesson() {
        appRouter.currentLessonIsReplay = false
        appRouter.currentLessonUnitColor = (Color(hex: "#8B5CF6"), Color(hex: "#6D28D9"))
        appRouter.currentLessonBonusEligible = false
        appRouter.currentLessonIsUnitTest = false
        appRouter.isTestLesson = true
        presentNativeLesson(lesson: MechanicsTestLesson.build(), startIndex: 0)
    }

    /// Debug: focused lab for the evolving multi-signal evidence container.
    private func openMultiSignalTestLesson() {
        appRouter.currentLessonIsReplay = false
        appRouter.currentLessonUnitColor = (Color(hex: "#A855F7"), Color(hex: "#7E22CE"))
        appRouter.currentLessonBonusEligible = false
        appRouter.currentLessonIsUnitTest = false
        appRouter.isTestLesson = true
        presentNativeLesson(lesson: MultiSignalTestLesson.build(), startIndex: 0)
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
            guard let self = self else { return }
            self.progress.reset()
            self.clearOnboardingData()
            self.refreshPathState()
            self.syncHearts()
            self.syncCourses()
            withAnimation(.easeInOut(duration: 0.28)) {
                self.appRouter.selectedTab = .home
                self.appRouter.currentScreen = .onboarding
            }
        })
        present(alert, animated: true)
    }

    private func clearOnboardingData() {
        let d = UserDefaults.standard
        [
            "onboarding.completed",
            "onboarding.experience",
            "onboarding.goals",
            "onboarding.dailyGoal"
        ].forEach { d.removeObject(forKey: $0) }
    }
}
