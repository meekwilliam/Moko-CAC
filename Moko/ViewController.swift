import UIKit
import SwiftUI
import StoreKit

// Fully native host: builds the SwiftUI AppRouter and drives it from the native
// GameData (bundled content) + ProgressStore (UserDefaults). No WebView.

class ViewController: UIViewController {
    private var appRouter = AppRouter()
    private var themeManager = ThemeManager()
    private var routerHost: UIHostingController<AppRouterView>?
    private var activeTestOutUnit: Int?

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
        appRouter.onCompleteTestOut = { [weak self] correct, total in self?.completeTestOut(correct: correct, total: total) }

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
        appRouter.onStartUnlimitedTrial = { [weak self] in self?.presentUnlimitedTrial() }
        appRouter.onRestorePurchases = { [weak self] in self?.restorePurchases() }
        appRouter.onPurchaseSubscription = { [weak self] id in self?.purchaseSubscription(productID: id) }
        // Old installs may hold a course id that no longer exists (courses were
        // restructured into levels) — fall back to the first level.
        if !Game.courses.contains(where: { $0.id == progress.currentCourse }) {
            progress.switchCourse(Game.defaultCourseId)
        }
        syncHearts()
        syncCourses()
        // Reflect any already-active subscription on launch (e.g. after reinstall).
        refreshSubscriptionStatus()
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

    private static let unlimitedMonthlyID = "com.meeko.moko.unlimitedhearts.monthly"
    private static let unlimitedYearlyID = "com.meeko.moko.unlimitedhearts.yearly"
    private static let unlimitedProductIDs: Set<String> = [unlimitedMonthlyID, unlimitedYearlyID]

    /// Hearts card "Free Trial" shortcut — purchases the monthly plan.
    private func presentUnlimitedTrial() {
        purchaseSubscription(productID: Self.unlimitedMonthlyID)
    }

    /// Purchase a specific subscription tier (monthly or yearly). Real StoreKit 2
    /// flow — in the simulator this presents Apple's actual purchase sheet, backed
    /// by the local Products.storekit testing configuration (no real charges).
    private func purchaseSubscription(productID: String) {
        Task { [weak self] in
            guard let self = self else { return }
            do {
                let products = try await Product.products(for: [productID])
                guard let product = products.first else {
                    self.presentStoreError("Product not found. Make sure the StoreKit configuration is enabled for this scheme (Edit Scheme → Run → Options → StoreKit Configuration).")
                    return
                }
                let result = try await product.purchase()
                switch result {
                case .success(let verification):
                    if case .verified(let transaction) = verification {
                        await transaction.finish()
                        self.progress.setUnlimitedHearts(true)
                        self.syncHearts()
                        Haptics.impact(.medium)
                    }
                case .userCancelled, .pending:
                    break
                @unknown default:
                    break
                }
            } catch {
                self.presentStoreError(error.localizedDescription)
            }
        }
    }

    private func restorePurchases() {
        // Ask StoreKit to sync with the App Store, then re-check entitlements.
        // In the simulator this restores any active test transaction.
        Task { [weak self] in
            guard let self = self else { return }
            do {
                try await AppStore.sync()
                let active = await self.hasActiveUnlimitedEntitlement()
                self.progress.setUnlimitedHearts(active)
                self.syncHearts()
                if active {
                    Haptics.success()
                    self.presentStoreInfo(title: "Restored", message: "Your Unlimited Hearts subscription is active.")
                } else {
                    self.presentStoreInfo(title: "Nothing to Restore", message: "No active subscription was found for this account.")
                }
            } catch {
                self.presentStoreError(error.localizedDescription)
            }
        }
    }

    /// Reads current StoreKit entitlements and mirrors the active state into
    /// ProgressStore. Called on launch so a valid subscription is reflected even
    /// after a reinstall, without requiring an explicit restore tap.
    private func refreshSubscriptionStatus() {
        Task { [weak self] in
            guard let self = self else { return }
            let active = await self.hasActiveUnlimitedEntitlement()
            if active != self.progress.isUnlimitedHearts {
                self.progress.setUnlimitedHearts(active)
                self.syncHearts()
            }
        }
    }

    /// True if there's a verified, unrevoked entitlement for any unlimited-hearts tier.
    private func hasActiveUnlimitedEntitlement() async -> Bool {
        for await result in Transaction.currentEntitlements {
            guard case .verified(let transaction) = result else { continue }
            if Self.unlimitedProductIDs.contains(transaction.productID),
               transaction.revocationDate == nil {
                return true
            }
        }
        return false
    }

    private func presentStoreError(_ message: String) {
        presentStoreInfo(title: "Store Error", message: message)
    }

    private func presentStoreInfo(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }

    // MARK: - Courses

    private func syncCourses() {
        appRouter.currentCourseId = progress.currentCourse
        var counts: [String: Int] = [:]
        for c in Game.courses { counts[c.id] = progress.lessonsDone(course: c.id) }
        appRouter.courseLessonsDone = counts
    }

    private func openCourses() {
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

    private func openTestOut(unit: Int) {
        let course = Game.course(progress.currentCourse)
        guard let test = course.testOuts?.first(where: { $0.unitIndex == unit }) else { return }
        let shuffled = test.questionPool.shuffled()
        var screens: [LessonScreen] = []
        // Competency blueprint first: every attempt must cover each slot's
        // skill `count` times, so a random draw can't skip a core skill.
        for slot in test.blueprint ?? [] {
            let matches = shuffled.filter { candidate in
                candidate.skillId == slot.skillId && !screens.contains(where: { $0.id == candidate.id })
            }
            screens.append(contentsOf: matches.prefix(slot.count))
        }
        var coveredSkills = Set(screens.map { $0.skillId ?? $0.type })
        for screen in shuffled {
            if screens.count >= test.questionCount { break }
            guard !screens.contains(where: { $0.id == screen.id }) else { continue }
            let skill = screen.skillId ?? screen.type
            if coveredSkills.insert(skill).inserted { screens.append(screen) }
        }
        if screens.count < test.questionCount {
            for screen in shuffled where !screens.contains(where: { $0.id == screen.id }) {
                screens.append(screen)
                if screens.count == test.questionCount { break }
            }
        }
        screens = Array(screens.prefix(test.questionCount)).shuffled()
        guard !screens.isEmpty else { return }
        activeTestOutUnit = unit
        let lesson = Lesson(node: -(unit + 1), title: "TEST OUT: \(course.sections[unit].title)",
                            celebration: "Assessment complete.", featurePromo: nil,
                            lessonType: "TEST_OUT", screens: screens)
        appRouter.currentLessonIsReplay = false
        appRouter.currentLessonUnitColor = (Color(hex: "#2563EB"), Color(hex: "#B7791F"))
        appRouter.currentLessonBonusEligible = false
        appRouter.currentLessonIsUnitTest = false
        appRouter.isTestLesson = true
        presentNativeLesson(lesson: lesson, startIndex: 0)
    }

    private func completeTestOut(correct: Int, total: Int) {
        guard let unit = activeTestOutUnit else { return }
        activeTestOutUnit = nil
        let course = Game.course(progress.currentCourse)
        guard let test = course.testOuts?.first(where: { $0.unitIndex == unit }) else { return }
        if correct >= test.passingScore {
            let nodes = course.nodes.filter { $0.sectionIndex == unit }.map(\.num).sorted()
            // Unit 10's Final Boss remains required for full course mastery.
            progress.recordTestOut(unit: unit, completedNodes: unit == 9 ? Array(nodes.dropLast()) : nodes)
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
