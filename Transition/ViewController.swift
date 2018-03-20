//
//  ViewController.swift
//  Transition
//
//  Created by duan on 2018/3/20.
//  Copyright © 2018年 monk-studio. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import TinyConstraints


class ViewController: UIViewController {

    let disposeBag = DisposeBag()
    var swipeInteractionController: SwipePresentInteractionController!
    var targetVC: SwipeViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.gray

        swipeInteractionController = SwipePresentInteractionController(viewController: self)

        let button = UIButton()
        button.setTitle("Present", for: .normal)
        view.addSubview(button)
        button.center(in: view)
        button.rx.tap
            .subscribe(onNext: { [unowned self] _ in
                let detailVC = DetailViewController(nibName: nil, bundle: nil)
                let vc = SwipeViewController.init(vc: detailVC)
                vc.modalPresentationStyle = .custom
                vc.transitioningDelegate = self
                self.present(vc, animated: true, completion: nil)
            })
            .disposed(by: disposeBag)
    }
}

extension ViewController: UIViewControllerTransitioningDelegate {

    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SwipePresentAnimationController(interactionController: self.swipeInteractionController)
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard let swipeVC = dismissed as? SwipeViewController else {
            return nil
        }
        return SwipeDismissAnimationController(interactionController: swipeVC.swipeInteractionController)
    }

    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning)
        -> UIViewControllerInteractiveTransitioning? {
        guard let animator = animator as? SwipeDismissAnimationController,
            let interactionController = animator.interactionController,
            interactionController.interactionInProgress
            else {
                return nil
        }
        return interactionController
    }

    func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        guard let animator = animator as? SwipePresentAnimationController,
            let interactionController = animator.interactionController,
            interactionController.interactionInProgress
            else {
                return nil
        }
        return interactionController
    }

}
