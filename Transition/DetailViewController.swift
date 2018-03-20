//
//  DetailViewController.swift
//  Transition
//
//  Created by duan on 2018/3/20.
//  Copyright © 2018年 monk-studio. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import TinyConstraints


class DetailViewController: UIViewController {

    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.brown

        let button = UIButton()
        button.setTitle("Dismiss", for: .normal)
        view.addSubview(button)
        button.center(in: view)
        button.rx.tap
            .subscribe(onNext: { [unowned self] _ in
                self.dismiss(animated: true, completion: nil)
            })
            .disposed(by: disposeBag)
    }
}

