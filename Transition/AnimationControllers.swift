//
//  AnimationControllers.swift
//  Transition
//
//  Created by duan on 2018/3/20.
//  Copyright © 2018年 monk-studio. All rights reserved.
//

import UIKit


class SwipePresentAnimationController: NSObject, UIViewControllerAnimatedTransitioning {

    let interactionController: SwipePresentInteractionController?

    init(interactionController: SwipePresentInteractionController?) {
        self.interactionController = interactionController
    }

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toVC = transitionContext.viewController(forKey: .to) as? SwipeViewController else {
            return
        }
        let containerView = transitionContext.containerView
        containerView.addSubview(toVC.view)

        let duration = transitionDuration(using: transitionContext)

        toVC.view.layoutIfNeeded()
        toVC.leadingConstraint.constant = 0
        UIView.animate(withDuration: duration, animations: {
            toVC.view.layoutIfNeeded()
            toVC.translucentView.alpha = 1
        }, completion: { (finished) in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
}


class SwipeDismissAnimationController: NSObject, UIViewControllerAnimatedTransitioning {

    let interactionController: SwipeDismissInteractionController?

    init(interactionController: SwipeDismissInteractionController?) {
        self.interactionController = interactionController
    }

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewController(forKey: .from) as? SwipeViewController else {
            return
        }

        let duration = transitionDuration(using: transitionContext)

        fromVC.leadingConstraint.constant = -fromVC.contentWidth
        UIView.animate(withDuration: duration, animations: {
            fromVC.view.layoutIfNeeded()
            fromVC.translucentView.alpha = 0
        }, completion: { _ in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
}
