import SwiftUI
import Combine

enum AppScreen {
    case none
    case main          // the tabbed shell (path / quest / leaderboard / profile)
    case lesson
    case legal(LegalDoc)
    case hearts        // hearts / regeneration screen
}

enum MainTab: Hashable {
    case home, quest, leaderboard, profile
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

    // Callbacks to JS bridge
    var onToggleReminders: ((Bool) -> Void)?
    var onClearData: (() -> Void)?
    var onCompleteLesson: ((Int) -> Void)?
    var onSaveLessonProgress: ((Int) -> Void)?
    var onExitLesson: (() -> Void)?
    var onOpenLesson: ((Int) -> Void)?
    var onRequestPath: (() -> Void)?
    var onRequestProfile: (() -> Void)?
    var onOpenHearts: (() -> Void)?
    var onUnlockAll: (() -> Void)?
    var requestLegalDoc: ((String) -> Void)?

    // Live heart state for the UI (mirrors ProgressStore).
    @Published var hearts: Int = ProgressStore.maxHearts
    @Published var secondsUntilNextHeart: Int? = nil
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
                        onClose: {
                            if let exit = router.onExitLesson {
                                exit()
                            } else {
                                withAnimation(.easeInOut(duration: 0.28)) { router.currentScreen = .main }
                            }
                        },
                        onComplete: { nodeNum in
                            router.onCompleteLesson?(nodeNum)
                        },
                        onSaveProgress: { screen in
                            router.onSaveLessonProgress?(screen)
                        }
                    )
                    .transition(.move(edge: .bottom))   // slides up to open, down to close
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
