//
//  SwipeViewController.swift
//  Transition
//
//  Created by duan on 2018/3/20.
//  Copyright © 2018年 monk-studio. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import TinyConstraints


class SwipeViewController: UIViewController {
    let translucentView = UIView()
    let contentVC: UIViewController
    let contentWidth: CGFloat
    var leadingConstraint: Constraint!

    var swipeInteractionController: SwipeDismissInteractionController!

    let disposeBag = DisposeBag()

    init(vc: UIViewController, contentWidth: CGFloat = 200) {
        self.contentVC = vc
        self.contentWidth = contentWidth
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        translucentView.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        view.addSubview(translucentView)
        translucentView.edgesToSuperview()
        translucentView.alpha = 0
        let tapGesture = UITapGestureRecognizer()
        translucentView.addGestureRecognizer(tapGesture)
        tapGesture.rx.event.subscribe { [weak self] _ in
            guard let self_ = self else { return }
            self_.dismiss(animated: true, completion: nil)
        }.disposed(by: disposeBag)

        addChildViewController(self.contentVC)
        view.addSubview(contentVC.view)
        contentVC.view.topToSuperview()
        contentVC.view.bottomToSuperview()
        leadingConstraint = contentVC.view.leadingToSuperview()
        leadingConstraint.constant = -contentWidth
        contentVC.view.width(self.contentWidth)

        self.swipeInteractionController = SwipeDismissInteractionController(viewController: self)
    }
}
