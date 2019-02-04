//
//  WelcomeScreenController.swift
//  kinesysV2
//
//  Created by Chris Davis on 2/3/19.
//  Copyright © 2019 Chris Davis. All rights reserved.
//

import UIKit



class WelcomeScreenController: UIViewController {
    
    let buttonHeight: CGFloat = 60
    
    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("log in", for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir-Light", size: 22)
        button.setTitleColor(UIColor.black, for: .normal)
        button.backgroundColor = .white
        button.addTarget(self, action: #selector(handleGoToLogin), for: .touchUpInside)
        return button
    }()
    
    let signupButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("sign up", for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir-Light", size: 22)
        button.setTitleColor(UIColor.black, for: .normal)
        button.backgroundColor = .white
        button.addTarget(self, action: #selector(handleGoToSignup), for: .touchUpInside)
        return button
    }()
    
    let seperatorLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.gray
        view.widthAnchor.constraint(equalToConstant: 1).isActive = true
        view.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.6)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
//        let topView = UIStackView(arrangedSubviews: [UIView(), logo, UIView()])
//        topView.distribution = .equalSpacing
//        topView.heightAnchor.constraint(equalToConstant: 60)
//        topView.backgroundColor = .white
        
        let mainView = WelcomeScreenView()
        
        
        
        let bottomView = UIStackView(arrangedSubviews: [UIView(), loginButton, seperatorLine, signupButton, UIView()])
        bottomView.heightAnchor.constraint(equalToConstant: buttonHeight).isActive = true
        bottomView.distribution = .equalCentering
        
        let overallStackView = UIStackView(arrangedSubviews: [mainView, bottomView])
        
        view.addSubview(overallStackView)
        overallStackView.axis = .vertical
        overallStackView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
        overallStackView.translatesAutoresizingMaskIntoConstraints = false
        navigationController?.isNavigationBarHidden = true
    }
    
    @objc fileprivate func handleGoToLogin() {
        print("go to log in screen")
        let loginController = LoginController()
        navigationController?.pushViewController(loginController, animated: true)
    }
    
    @objc fileprivate func handleGoToSignup() {
        print("go to sign up screen")
        let signupController = SignupController()
        navigationController?.pushViewController(signupController, animated: true)
    }

}
