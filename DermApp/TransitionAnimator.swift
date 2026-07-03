import UIKit

// MARK: - Level transitions
// Recreates the web "stack of levels" metaphor natively:
//  • Descend (home→path, path→lesson): the current screen lifts up and off to
//    reveal the level sitting beneath it; dismissing, the upper screen drops
//    back down from the top to cover it.
//  • Ascend (home→profile): the new screen drops down from the top over the
//    current one (which sinks a little); dismissing, it lifts back up.
//
// Two underlying motions:
//   Motion X  "reveal by lifting" — top view slides up/off, lower view settles.
//   Motion Y  "cover from top"    — top view drops from the top, lower view sinks.

final class LevelTransitionDelegate: NSObject, UIViewControllerTransitioningDelegate {
    enum Style { case descend, ascend }
    let style: Style
    init(style: Style) { self.style = style }

    func animationController(forPresented presented: UIViewController,
                             presenting: UIViewController,
                             source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        LevelAnimator(style: style, presenting: true)
    }
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        LevelAnimator(style: style, presenting: false)
    }
}

final class LevelAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    let style: LevelTransitionDelegate.Style
    let presenting: Bool
    init(style: LevelTransitionDelegate.Style, presenting: Bool) {
        self.style = style; self.presenting = presenting
    }

    func transitionDuration(using ctx: UIViewControllerContextTransitioning?) -> TimeInterval { 0.5 }

    /// Motion X applies to a descend-present or an ascend-dismiss (top view lifts
    /// away). Everything else is Motion Y (a view drops in from the top).
    private var isMotionX: Bool {
        (style == .descend && presenting) || (style == .ascend && !presenting)
    }

    func animateTransition(using ctx: UIViewControllerContextTransitioning) {
        let container = ctx.containerView
        guard let fromView = ctx.viewController(forKey: .from)?.view,
              let toView   = ctx.viewController(forKey: .to)?.view else {
            ctx.completeTransition(false); return
        }

        let bounds = container.bounds
        let H = bounds.height
        // Transparent so whatever sits behind stays visible while a view slides in.
        container.backgroundColor = .clear
        toView.frame = bounds
        fromView.frame = bounds

        let sink = CGAffineTransform(scaleX: 0.94, y: 0.94)
        let up = CGAffineTransform(translationX: 0, y: -H)
        let duration = transitionDuration(using: ctx)

        let dim = UIView(frame: bounds)
        dim.backgroundColor = .black
        dim.isUserInteractionEnabled = false

        func animate(_ body: @escaping () -> Void, done: @escaping () -> Void) {
            UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 0.88,
                           initialSpringVelocity: 0.1, options: [.curveEaseInOut], animations: body) { _ in
                dim.removeFromSuperview()
                done()
                ctx.completeTransition(!ctx.transitionWasCancelled)
            }
        }

        if presenting {
            if toView.superview == nil { container.addSubview(toView) }
            if isMotionX {
                // Descend present: the current screen lifts up (via a snapshot, since
                // it lives behind the container) to reveal the level beneath (toView).
                container.insertSubview(toView, at: 0)
                toView.transform = sink
                dim.alpha = 0.28
                container.insertSubview(dim, aboveSubview: toView)
                let snap = fromView.snapshotView(afterScreenUpdates: false) ?? UIView(frame: bounds)
                snap.frame = bounds
                container.addSubview(snap)
                animate({ snap.transform = up; toView.transform = .identity; dim.alpha = 0 },
                        done: { snap.removeFromSuperview() })
            } else {
                // Ascend present: new screen drops from the top; the one behind sinks.
                container.bringSubviewToFront(toView)
                dim.alpha = 0
                container.insertSubview(dim, belowSubview: toView)
                toView.transform = up
                animate({ toView.transform = .identity; fromView.transform = sink; dim.alpha = 0.28 },
                        done: { fromView.transform = .identity })
            }
        } else {
            // Dismiss: UIKit already has both views in the container.
            if toView.superview == nil { container.insertSubview(toView, belowSubview: fromView) }
            if isMotionX {
                // Ascend dismiss: top screen (fromView) lifts up; revealed one settles.
                toView.transform = sink
                dim.alpha = 0.28
                container.insertSubview(dim, aboveSubview: toView)
                animate({ fromView.transform = up; toView.transform = .identity; dim.alpha = 0 },
                        done: { fromView.transform = .identity })
            } else {
                // Descend dismiss: revealed screen (toView) drops from top over the
                // dismissing one (fromView), which sinks beneath it.
                container.bringSubviewToFront(toView)
                dim.alpha = 0
                container.insertSubview(dim, belowSubview: toView)
                toView.transform = up
                animate({ toView.transform = .identity; fromView.transform = sink; dim.alpha = 0.28 },
                        done: { fromView.transform = .identity })
            }
        }
    }
}
