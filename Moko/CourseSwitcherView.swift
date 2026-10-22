import SwiftUI

// MARK: - Level picker
// The Day Trading course is split into 4 difficulty levels (Beginner →
// Intermediate → Advanced → Expert). This picker — opened by tapping the top
// path banner — lets you switch levels, but each level stays locked until the
// previous one is fully completed.

struct CourseSwitcherView: View {
    @ObservedObject var router: AppRouter
    @EnvironmentObject var theme: ThemeManager
    var onPick: (String) -> Void
    var onClose: () -> Void
    @State private var rowsVisible = false

    private func done(_ c: Course) -> Int { router.courseLessonsDone[c.id] ?? 0 }
    private func total(_ c: Course) -> Int { c.nodes.count }
    private func isComplete(_ c: Course) -> Bool { done(c) >= total(c) && total(c) > 0 }

    /// A level is unlocked if it's the first, or the previous level is finished.
    /// Standalone strategy tracks (no difficulty `level`) sit outside the
    /// Beginner→Expert ladder and are always open.
    private func isUnlocked(_ index: Int) -> Bool {
        guard index > 0 else { return true }
        if Game.courses[index].level == nil { return true }
        return isComplete(Game.courses[index - 1])
    }

    var body: some View {
        ZStack {
            theme.palette.base.ignoresSafeArea()
            VStack(spacing: 0) {
                header
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 14) {
                        ForEach(Array(Game.courses.enumerated()), id: \.element.id) { i, course in
                            levelRow(course, index: i)
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 18)
                }
            }
        }
        .onAppear {
            withAnimation(.spring(response: 0.42, dampingFraction: 0.86)) {
                rowsVisible = true
            }
        }
    }

    private var header: some View {
        ZStack {
            VStack(spacing: 2) {
                Text("Courses")
                    .font(Theme.font(20, .black)).foregroundColor(theme.palette.ink)
                Text("Switch anytime. Your progress is saved.")
                    .font(Theme.font(12, .bold)).foregroundColor(theme.palette.muted)
            }
            HStack {
                Button(action: { Haptics.selection(); onClose() }) {
                    Image(systemName: "xmark")
                        .font(.system(size: 19, weight: .bold))
                        .foregroundColor(theme.palette.muted)
                }
                Spacer()
            }
        }
        .padding(.horizontal, 22).padding(.top, 12)
    }

    private func levelRow(_ course: Course, index: Int) -> some View {
        let selected = router.currentCourseId == course.id
        let accent = Color(hex: course.color)
        let unlocked = isUnlocked(index)
        let complete = isComplete(course)

        return Button(action: {
            guard unlocked else { Haptics.error(); return }
            Haptics.selection()
            onPick(course.id)
        }) {
            HStack(spacing: 16) {
                // Level badge — number when unlocked, lock when not.
                RoundedRectangle(cornerRadius: 14, style: .continuous)
                    .fill(unlocked ? accent.opacity(0.18) : Theme.surfaceRaised.opacity(0.55))
                    .frame(width: 54, height: 54)
                    .overlay(
                        Group {
                            if unlocked {
                                Text("\(course.level ?? index + 1)")
                                    .font(Theme.font(24, .black)).foregroundColor(accent)
                            } else {
                                Image(systemName: "lock.fill")
                                    .font(.system(size: 20, weight: .bold))
                                    .foregroundColor(theme.palette.muted)
                            }
                        }
                    )

                VStack(alignment: .leading, spacing: 3) {
                    Text(course.name)
                        .font(Theme.font(18, .black))
                        .foregroundColor(unlocked ? theme.palette.ink : theme.palette.muted)
                    Text(unlocked
                         ? "\(index == 0 ? "Beginner" : "Advanced") · \(done(course)) / \(total(course)) lessons"
                         : "Finish \(Game.courses[index - 1].name) to unlock")
                        .font(Theme.font(13, .bold)).foregroundColor(theme.palette.muted)
                }
                Spacer(minLength: 0)
                if selected {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: 22, weight: .bold)).foregroundColor(accent)
                } else if complete {
                    Image(systemName: "checkmark.seal.fill")
                        .font(.system(size: 20, weight: .bold)).foregroundColor(accent.opacity(0.7))
                } else if !unlocked {
                    Image(systemName: "lock.fill")
                        .font(.system(size: 16, weight: .bold)).foregroundColor(theme.palette.muted)
                }
            }
            .padding(16)
            .background(
                RoundedRectangle(cornerRadius: 18, style: .continuous)
                    .fill(unlocked ? Theme.surface : Theme.surfaceRaised.opacity(0.55))
                    .overlay(RoundedRectangle(cornerRadius: 18, style: .continuous)
                        .strokeBorder(selected ? accent.opacity(0.6) : Theme.surfaceBorder.opacity(0.65),
                                      lineWidth: selected ? 2 : 1.5))
            )
            .opacity(unlocked ? 1 : 0.6)
            .contentShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
        }
        .buttonStyle(RowPressStyle())
        .disabled(!unlocked)
        .opacity(rowsVisible ? 1 : 0)
        .offset(y: rowsVisible ? 0 : 18)
        .animation(.spring(response: 0.4, dampingFraction: 0.84).delay(Double(index) * 0.035), value: rowsVisible)
    }
}
