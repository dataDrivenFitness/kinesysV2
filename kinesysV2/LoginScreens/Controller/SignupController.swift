//
//  LoginController.swift
//  kinesysV2
//
//  Created by Chris Davis on 1/21/19.
//  Copyright © 2019 Chris Davis. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

protocol SignupControllerDelegate {
    func didFinishLoggingIn()
}

class SignupController: UIViewController, SignupControllerDelegate {
    
    var delegate: SignupControllerDelegate?
    
    let logoText: UILabel = {
        let text = UILabel()
        text.text = "KINESYS"
        text.font = UIFont(name: "Avenir-Light", size: 50)
        text.textColor = .orange
        text.textAlignment = .center
        text.heightAnchor.constraint(equalToConstant: 100).isActive = true
        return text
    }()
    
    let emailTextField: CustomTextField = {
        let tf = CustomTextField(padding: 24, height: 44)
        tf.placeholder = "enter email"
        tf.keyboardType = .emailAddress
        tf.backgroundColor = .white
        //        tf.textColor = UIColor.orange
        tf.layer.borderColor = UIColor.orange.cgColor
        tf.layer.borderWidth = 1
        tf.font = UIFont(name: "Avenir-Light", size: 20)
        tf.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
        return tf
    }()
    let passwordTextField: CustomTextField = {
        let tf = CustomTextField(padding: 24, height: 44)
        tf.placeholder = "enter password"
        tf.isSecureTextEntry = true
        tf.backgroundColor = .white
        //        tf.textColor = UIColor.orange
        tf.layer.borderColor = UIColor.orange.cgColor
        tf.layer.borderWidth = 1
        tf.font = UIFont(name: "Avenir-Light", size: 20)
        tf.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
        return tf
    }()
    let confirmPasswordTextField: CustomTextField = {
        let tf = CustomTextField(padding: 24, height: 44)
        tf.placeholder = "re-enter password"
        tf.isSecureTextEntry = true
        tf.backgroundColor = .white
        //        tf.textColor = UIColor.orange
        tf.layer.borderColor = UIColor.orange.cgColor
        tf.layer.borderWidth = 1
        tf.font = UIFont(name: "Avenir-Light", size: 20)
        tf.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
        return tf
    }()
    
    let signupButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log In", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir-Light", size: 20)
        //        button.backgroundColor = .orange
        button.backgroundColor = UIColor.lightGray
        button.setTitleColor(UIColor.darkGray, for: .disabled)
        button.heightAnchor.constraint(equalToConstant: 44).isActive = true
        button.layer.cornerRadius = 22
        button.addTarget(self, action: #selector(handleSignup), for: .touchUpInside)
        return button
    }()
    
    let gotoSignupButton: UIButton = {
        let button = UIButton()
        button.setTitle("log in", for: .normal)
        button.setTitleColor(.orange, for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir-Light", size: 20)
        button.addTarget(self, action: #selector(handleBack), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        view.backgroundColor = .white
        
        setupLayout()
        setupNotificationObservers()
        setupTapGesture()
        setupLoginViewModelObserver()
    }
    
    func didFinishLoggingIn() {
        fetchCurrentUser()
    }
    
    fileprivate func fetchCurrentUser() {
        print("fetching current user")
    }
    
    let loginViewModel = LoginViewModel()
    fileprivate func setupLoginViewModelObserver() {
        loginViewModel.isFormValidObserver = { [unowned self] (isFormValid) in
            print("Form is changing, is it valid?", isFormValid)
            
            self.signupButton.isEnabled = isFormValid
            if isFormValid {
                self.signupButton.backgroundColor = .orange
                self.signupButton.setTitleColor(.white, for: .normal)
            } else {
                self.signupButton.backgroundColor = .lightGray
                self.signupButton.setTitleColor(.gray, for: .normal)
            }
        }
    }
    
    @objc fileprivate func handleGotoSignUp() {
        let signupController = SignupController()
        navigationController?.pushViewController(signupController, animated: true)
    }
    
    @objc fileprivate func handleBack() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc fileprivate func handleTextChange(textField: UITextField) {
        if textField == emailTextField {
            loginViewModel.email = textField.text
        } else {
            loginViewModel.password = textField.text
        }
    }
    
    @objc fileprivate func handleSignup() {
        self.handleTapDismiss()
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        guard let confirmPassword = confirmPasswordTextField.text else { return }
        
        if password != confirmPassword {
            SVProgressHUD.setDefaultMaskType(.gradient)
            SVProgressHUD.setHapticsEnabled(true)
            SVProgressHUD.showError(withStatus: "password does not match")
            SVProgressHUD.dismiss(withDelay: 1.5)
            
        } else {
            
            Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
                if error != nil {
                    SVProgressHUD.setDefaultMaskType(.gradient)
                    SVProgressHUD.setHapticsEnabled(true)
                    SVProgressHUD.showError(withStatus: "not a valid email")
                    SVProgressHUD.dismiss(withDelay: 1.5)
                    print(error!)
                } else {
                    SVProgressHUD.setDefaultMaskType(.gradient)
                    SVProgressHUD.setHapticsEnabled(true)
                    SVProgressHUD.show(withStatus: "let's do this!")
                    SVProgressHUD.dismiss(withDelay: 2)
                    
                    let newVC = OnboardingController()
                    self.navigationController?.pushViewController(newVC, animated: true)
                    
//                    self.dismiss(animated: true, completion: nil)
                }
            }
            
        }
    }
    
    @objc func handleTapDismiss() {
        self.view.endEditing(true)
    }
    
    fileprivate func setupTapGesture() {
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapDismiss)))
    }
    
    fileprivate func setupNotificationObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc fileprivate func handleKeyboardHide() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.transform = .identity
        })
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc fileprivate func handleKeyboardShow(notification: Notification) {
        guard let value = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        
        let keyboardFrame = value.cgRectValue
        print(keyboardFrame)
        
        let bottomSpace = view.frame.height - stackView.frame.origin.y - stackView.frame.height
        print(bottomSpace)
        
        let difference = keyboardFrame.height - bottomSpace
        self.view.transform = CGAffineTransform(translationX: 0, y: -difference - 8)
    }
    
    lazy var stackView = UIStackView(arrangedSubviews: [
        logoText,
        emailTextField,
        passwordTextField,
        confirmPasswordTextField,
        signupButton
        ])
    
    fileprivate func setupLayout() {
        stackView.axis = .vertical
        stackView.spacing = 12
        view.addSubview(stackView)
        
        stackView.anchor(top: nil, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 0, left: 60, bottom: 0, right: 60))
        stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        view.addSubview(gotoSignupButton)
        gotoSignupButton.anchor(top: nil, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor)
    }
}
