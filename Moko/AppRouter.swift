import SwiftUI
import Combine

enum AppScreen {
    case none
    case main
    case lesson
    case legal(LegalDoc)
    case hearts
    case courses
    case streak
    case onboarding
}

enum MainTab: Hashable {
    case home, quest, leaderboard, profile
}

final class AppRouter: ObservableObject {
    @Published var currentScreen: AppScreen = .none
    @Published var showSplash: Bool = true
    @Published var selectedTab: MainTab = .home
    @Published var pathStore: PathStore?
    @Published var profileStore: ProfileStore?
    @Published var currentLesson: Lesson?
    @Published var currentLessonStartIndex: Int = 0
    @Published var currentLessonIsReplay: Bool = false
    @Published var currentLessonUnitColor: (main: Color, dark: Color)? = nil
    @Published var currentLessonBonusEligible: Bool = false
    @Published var currentLessonIsUnitTest: Bool = false
    @Published var isTestLesson: Bool = false

    var onToggleReminders: ((Bool) -> Void)?
    var onClearData: (() -> Void)?
    var onCompleteLesson: ((Int) -> Void)?
    var onSaveLessonProgress: ((Int) -> Void)?
    var onSpendQuestionHeart: (() -> Bool)?
    var onExitLesson: (() -> Void)?
    var onOpenLesson: ((Int) -> Void)?
    var onOpenTestOut: ((Int) -> Void)?
    var onCompleteTestOut: ((Int, Int, [String: Int], [String: Int]) -> Void)?
    var onRequestPath: (() -> Void)?
    var onRequestProfile: (() -> Void)?
    var onOpenHearts: (() -> Void)?
    var onUnlockAll: (() -> Void)?
    var onPreviewStreak: (() -> Void)?
    var onBumpStreak: (() -> Void)?
    var onGrantTestTreats: (() -> Void)?
    var onOnboardingFinished: (() -> Void)?
    var onOpenCourses: (() -> Void)?
    var onSelectCourse: ((String) -> Void)?
    var onRefillHearts: (() -> Void)?
    var onInviteFriend: (() -> Void)?
    var requestLegalDoc: ((String) -> Void)?

    @Published var hearts: Int = ProgressStore.maxHearts
    @Published var secondsUntilNextHeart: Int? = nil
    @Published var treats: Int = 0
    @Published var currentCourseId: String = Game.defaultCourseId
    @Published var courseLessonsDone: [String: Int] = [:]

    @Published var streakCount: Int = 0
    @Published var streakWeek: [(label: String, active: Bool, isToday: Bool)] = []

    @Published var curtainColor: Color? = nil
    @Published var curtainOrigin: CGPoint = .zero
    @Published var curtainScale: CGFloat = 0.0001
    @Published var curtainOpacity: Double = 1
}

struct AppRouterView: View {
    @ObservedObject var router: AppRouter
    @ObservedObject var theme: ThemeManager

    var body: some View {
        content
            .environmentObject(theme)
            .environment(\.colorScheme, theme.palette.scheme)
            .preferredColorScheme(theme.palette.scheme)
    }

    private var content: some View {
        ZStack {
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
                        isUnitTest: router.currentLessonIsUnitTest,
                        hearts: router.hearts,
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
                        onAssessmentComplete: { correct, total, correctCompetencies, missedCompetencies in
                            router.onCompleteTestOut?(correct, total, correctCompetencies, missedCompetencies)
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
