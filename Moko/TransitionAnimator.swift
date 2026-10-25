import UIKit

// MARK: - Level transitions

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
                container.bringSubviewToFront(toView)
                dim.alpha = 0
                container.insertSubview(dim, belowSubview: toView)
                toView.transform = up
                animate({ toView.transform = .identity; fromView.transform = sink; dim.alpha = 0.28 },
                        done: { fromView.transform = .identity })
            }
        } else {
            if toView.superview == nil { container.insertSubview(toView, belowSubview: fromView) }
            if isMotionX {
                toView.transform = sink
                dim.alpha = 0.28
                container.insertSubview(dim, aboveSubview: toView)
                animate({ fromView.transform = up; toView.transform = .identity; dim.alpha = 0 },
                        done: { fromView.transform = .identity })
            } else {
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
