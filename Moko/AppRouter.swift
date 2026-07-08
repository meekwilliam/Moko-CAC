import SwiftUI
import Combine

enum AppScreen {
    case none
    case main          // the tabbed shell (path / quest / leaderboard / profile)
    case lesson
    case legal(LegalDoc)
    case hearts        // hearts / regeneration screen
    case courses       // course picker (like Duolingo's language switcher)
    case streak        // full-screen streak celebration (first lesson of the day)
    case onboarding    // first-run intake flow (also previewable from Profile)
}

enum MainTab: Hashable {
    case home, quest, simulation, leaderboard, premium, profile
}

final class AppRouter: ObservableObject {
    @Published var currentScreen: AppScreen = .none
    @Published var showSplash: Bool = true      // brief branded loading screen at launch
    @Published var selectedTab: MainTab = .home
    @Published var pathStore: PathStore?
    @Published var profileStore: ProfileStore?
    @Published var currentLesson: Lesson?
    @Published var currentLessonStartIndex: Int = 0
    @Published var currentLessonIsReplay: Bool = false
    // The lesson's own unit banner color (from section data) — works for any
    // unit size, rather than guessing from the node number.
    @Published var currentLessonUnitColor: (main: Color, dark: Color)? = nil
    // Whether completing the current lesson finishes its whole unit (any size).
    @Published var currentLessonBonusEligible: Bool = false
    // True while a debug/mechanics-test lesson is open — completing or exiting
    // it must NOT touch real progress (no recordCompletion, no saveInProgress).
    @Published var isTestLesson: Bool = false

    // Callbacks to JS bridge
    var onToggleReminders: ((Bool) -> Void)?
    var onClearData: (() -> Void)?
    var onCompleteLesson: ((Int) -> Void)?
    var onSaveLessonProgress: ((Int) -> Void)?
    var onSpendQuestionHeart: (() -> Bool)?
    var onExitLesson: (() -> Void)?
    var onOpenLesson: ((Int) -> Void)?
    var onRequestPath: (() -> Void)?
    var onRequestProfile: (() -> Void)?
    var onOpenHearts: (() -> Void)?
    var onUnlockAll: (() -> Void)?
    var onOpenMechanicsTest: (() -> Void)?
    var onPreviewStreak: (() -> Void)?
    var onBumpStreak: (() -> Void)?
    var onGrantTestTreats: (() -> Void)?
    var onOnboardingFinished: (() -> Void)?
    var onOpenCourses: (() -> Void)?
    var onSelectCourse: ((String) -> Void)?
    var onRefillHearts: (() -> Void)?
    var onInviteFriend: (() -> Void)?
    var onStartUnlimitedTrial: (() -> Void)?
    var onRestorePurchases: (() -> Void)?
    var onPurchaseSubscription: ((String) -> Void)?
    var requestLegalDoc: ((String) -> Void)?

    // Live heart state for the UI (mirrors ProgressStore).
    @Published var hearts: Int = ProgressStore.maxHearts
    @Published var secondsUntilNextHeart: Int? = nil
    @Published var isUnlimitedHearts: Bool = false
    @Published var treats: Int = 0
    // Which course is active (mirrors ProgressStore.currentCourse).
    @Published var currentCourseId: String = Game.defaultCourseId
    // Completed-lesson count per course id (for the switcher).
    @Published var courseLessonsDone: [String: Int] = [:]

    // Streak celebration screen data (set right before currentScreen = .streak).
    @Published var streakCount: Int = 0
    @Published var streakWeek: [(label: String, active: Bool, isToday: Bool)] = []

    // A full-screen color "curtain" that expands from a given screen point and
    // covers everything, independent of whatever's in `currentScreen` — used by
    // onboarding's hold-to-commit so the color visibly comes from the button
    // and stays on top through the screen swap to the lesson underneath, then
    // fades to reveal it already loaded (seamless, no flash/jump).
    @Published var curtainColor: Color? = nil
    @Published var curtainOrigin: CGPoint = .zero
    @Published var curtainScale: CGFloat = 0.0001
    @Published var curtainOpacity: Double = 1
}

struct AppRouterView: View {
    @ObservedObject var router: AppRouter
    @ObservedObject var theme: ThemeManager
    @Namespace var heroNamespace

    var body: some View {
        content
            .environmentObject(theme)
            .environment(\.colorScheme, theme.palette.scheme)   // force views (e.g. the lesson) to the theme scheme
            .preferredColorScheme(theme.palette.scheme)
    }

    private var content: some View {
        ZStack {
            // Background is technically clear so webview shows through if no screen
            Color.clear.ignoresSafeArea()

            switch router.currentScreen {
            case .none:
                EmptyView()

            case .main:
                MainTabView(router: router)
                    .transition(.opacity)

            case .lesson:
                if let lesson = router.currentLesson {
                    LessonView(
                        lesson: lesson,
                        startIndex: router.currentLessonStartIndex,
                        isReplay: router.currentLessonIsReplay,
                        unitColor: router.currentLessonUnitColor,
                        unitBonusEligible: router.currentLessonBonusEligible,
                        isTestLesson: router.isTestLesson,
                        hearts: router.hearts,
                        isUnlimitedHearts: router.isUnlimitedHearts,
                        onClose: {
                            if router.isTestLesson {
                                router.isTestLesson = false
                                withAnimation(.easeInOut(duration: 0.28)) { router.currentScreen = .main }
                            } else if let exit = router.onExitLesson {
                                exit()
                            } else {
                                withAnimation(.easeInOut(duration: 0.28)) { router.currentScreen = .main }
                            }
                        },
                        onComplete: { nodeNum in
                            if router.isTestLesson {
                                router.isTestLesson = false
                                withAnimation(.easeInOut(duration: 0.28)) { router.currentScreen = .main }
                            } else {
                                router.onCompleteLesson?(nodeNum)
                            }
                        },
                        onSaveProgress: { screen in
                            guard !router.isTestLesson else { return }
                            router.onSaveLessonProgress?(screen)
                        },
                        onSpendHeart: {
                            guard !router.isTestLesson else { return true }
                            return router.onSpendQuestionHeart?() ?? true
                        }
                    )
                    .transition(.asymmetric(
                        insertion: .move(edge: .bottom),
                        removal: .move(edge: .bottom)
                    ))
                    .zIndex(10)
                }

            case .legal(let doc):
                LegalSheetView(
                    doc: doc,
                    onBack: {
                        withAnimation(.easeInOut(duration: 0.28)) {
                            router.selectedTab = .profile
                            router.currentScreen = .main
                        }
                    }
                )
                .transition(.opacity)

            case .hearts:
                HeartsView(router: router,
                           onClose: { withAnimation(.easeInOut(duration: 0.28)) { router.currentScreen = .main } })
                    .transition(.move(edge: .bottom))
                    .zIndex(20)

            case .courses:
                CourseSwitcherView(
                    router: router,
                    onPick: { id in router.onSelectCourse?(id) },
                    onClose: { withAnimation(.easeInOut(duration: 0.28)) { router.currentScreen = .main } })
                    .transition(.move(edge: .bottom))
                    .zIndex(20)

            case .onboarding:
                OnboardingView(router: router)
                    .transition(.opacity)
                    .zIndex(40)

            case .streak:
                StreakCelebrationView(
                    count: router.streakCount,
                    week: router.streakWeek,
                    onContinue: {
                        withAnimation(.spring(response: 0.42, dampingFraction: 0.86)) {
                            router.selectedTab = .home
                            router.currentScreen = .main
                        }
                    })
                    .transition(.opacity)
                    .zIndex(30)
            }

            // Commit-burst curtain (see AppRouter.curtainColor) — sits above
            // every screen so it can persist through a screen swap underneath it.
            if let color = router.curtainColor {
                Circle()
                    .fill(color)
                    .frame(width: 140, height: 140)
                    .scaleEffect(router.curtainScale)
                    .position(router.curtainOrigin)
                    .opacity(router.curtainOpacity)
                    .ignoresSafeArea()
                    .allowsHitTesting(false)
                    .zIndex(500)
            }

            if router.showSplash {
                SplashView()
                    .transition(.opacity)
                    .zIndex(1000)
            }
        }
        .animation(.easeInOut(duration: 0.45), value: router.showSplash)
    }
}

// MARK: - Launch / loading screen
// Simple branded splash: the app icon on the app's dark background, gently
// breathing while the path loads. Auto-dismisses after a short beat.

struct SplashView: View {
    @EnvironmentObject var theme: ThemeManager
    @State private var breathe = false

    var body: some View {
        ZStack {
            theme.palette.base.ignoresSafeArea()
            VStack(spacing: 22) {
                Image("AppLogo")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 112, height: 112)
                    .clipShape(RoundedRectangle(cornerRadius: 26, style: .continuous))
                    .overlay(
                        RoundedRectangle(cornerRadius: 26, style: .continuous)
                            .strokeBorder(Color.white.opacity(0.08), lineWidth: 1)
                    )
                    .shadow(color: .black.opacity(0.4), radius: 18, y: 10)
                    .scaleEffect(breathe ? 1.04 : 0.96)

                Text("Moko")
                    .font(Theme.font(26, .black))
                    .foregroundColor(theme.palette.ink)
            }
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 1.0).repeatForever(autoreverses: true)) {
                breathe = true
            }
        }
    }
}
