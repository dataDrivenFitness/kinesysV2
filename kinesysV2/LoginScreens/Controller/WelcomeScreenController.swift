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
    
    func createButton(selector: Selector, text: String) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(text, for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir-Light", size: 18)
        button.backgroundColor = .white
        button.setTitleColor(UIColor.black, for: .normal)
        button.addTarget(self, action: selector, for: .touchUpInside)
        return button
    }
    
    lazy var loginButton = createButton(selector: #selector(handleGoToLogin), text: "log in")
    lazy var signupButton = createButton(selector: #selector(handleGoToSignup), text: "sign up")
    
    let seperatorLine: UIView = {
        let sl = UIView()
        sl.backgroundColor = UIColor.gray
        sl.widthAnchor.constraint(equalToConstant: 1).isActive = true
        return sl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationController?.isNavigationBarHidden = true
        
        setupViews()
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
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    fileprivate func setupViews() {
        let mainView = WelcomeScreenView()
        
        let bottomButtonView = UIStackView(arrangedSubviews: [
            UIView(),
            loginButton,
            seperatorLine,
            signupButton,
            UIView()])
        bottomButtonView.heightAnchor.constraint(equalToConstant: buttonHeight).isActive = true
        bottomButtonView.distribution = .equalCentering
        bottomButtonView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(mainView)
        mainView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 0, bottom: buttonHeight, right: 0))
        
        view.addSubview(bottomButtonView)
        bottomButtonView.anchor(top: nil, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
        
//        let overallStackView = UIStackView(arrangedSubviews: [mainView, bottomView])
//
//        view.addSubview(overallStackView)
//        overallStackView.axis = .vertical
//        overallStackView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
//        overallStackView.translatesAutoresizingMaskIntoConstraints = false
    }
}
