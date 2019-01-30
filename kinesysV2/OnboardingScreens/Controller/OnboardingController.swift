//
//  OnboardingController.swift
//  kinesysV2
//
//  Created by Chris Davis on 1/30/19.
//  Copyright © 2019 Chris Davis. All rights reserved.
//

import UIKit

class OnboardingController: UIViewController {
    
    let button:  UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log In", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir-Light", size: 20)
        //        button.backgroundColor = .orange
        button.backgroundColor = UIColor.lightGray
        button.setTitleColor(UIColor.darkGray, for: .disabled)
        button.heightAnchor.constraint(equalToConstant: 44).isActive = true
        button.layer.cornerRadius = 22
        button.addTarget(self, action: #selector(handleFinished), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        view.addSubview(button)
        button.anchor(top: nil, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 10, bottom: 10, right: 10))
    }
    
    @objc fileprivate func handleFinished() {
        self.dismiss(animated: true, completion: nil)
    }
}
