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
import PasswordTextField

class SignupController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let logoText: UILabel = {
        let text = UILabel()
        text.text = "KINESYS"
        text.font = UIFont(name: "Avenir-Light", size: 50)
        text.textColor = .orange
        text.textAlignment = .center
        text.heightAnchor.constraint(equalToConstant: 100).isActive = true
        return text
    }()
    
    let selectPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("select photo", for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir-Light", size: 20)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.orange.cgColor
        button.setTitleColor(UIColor.lightGray, for: .normal)
        button.backgroundColor = .white
        button.widthAnchor.constraint(equalToConstant: 200).isActive = true
        button.heightAnchor.constraint(equalToConstant: 200).isActive = true
        button.layer.cornerRadius = 100
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(handleSelectPhoto), for: .touchUpInside)
        return button
    }()
    
    fileprivate func createTextField(placeholder: String, keyboardType: UIKeyboardType) -> CustomTextField {
        let tf = CustomTextField(padding: 24, height: 44)
        tf.placeholder = placeholder
        tf.keyboardType = keyboardType
        tf.backgroundColor = .white
        tf.layer.borderColor = UIColor.orange.cgColor
        tf.layer.borderWidth = 1
        tf.font = UIFont(name: "Avenir-Light", size: 20)
        tf.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
        return tf
    }
    
    lazy var firstNameTextField = createTextField(placeholder: "enter first name", keyboardType: .default)
    lazy var lastNameTextField = createTextField(placeholder: "enter last name", keyboardType: .default)
    lazy var emailTextField = createTextField(placeholder: "enter email", keyboardType: .emailAddress)
//    lazy var confirmPasswordTextField = createTextField(placeholder: "re-enter password")
    
    let passwordTextField: PasswordTextField = {
        let pt = PasswordTextField()
        pt.placeholder = "enter password"
        pt.backgroundColor = .white
        pt.font = UIFont(name: "Avenir-Light", size: 20)
        pt.heightAnchor.constraint(equalToConstant: 44).isActive = true
        pt.layer.borderColor = UIColor.orange.cgColor
        pt.layer.borderWidth = 1
        pt.layer.cornerRadius = 22
        pt.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
        return pt
    }()
    
    let signupButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign up", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir-Light", size: 20)
        button.backgroundColor = UIColor.lightGray
        button.setTitleColor(.white, for: .disabled)
        button.heightAnchor.constraint(equalToConstant: 44).isActive = true
        button.layer.cornerRadius = 22
        button.addTarget(self, action: #selector(handleSignup), for: .touchUpInside)
        return button
    }()
    
    let gotoSignupButton: UIButton = {
        let button = UIButton()
        button.setTitle("back", for: .normal)
        button.setTitleColor(.black, for: .normal)
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
        setupSigninViewModelObserver()
    }
    
    func didFinishLoggingIn() {
        fetchCurrentUser()
    }
    
    fileprivate func fetchCurrentUser() {
        print("***fetching current user")
    }
    
    let signupViewModel = SignupViewModel()
    
    fileprivate func setupSigninViewModelObserver() {
        signupViewModel.bindableIsFormValid.bind { [unowned self] (isFormValid) in
            guard let isFormValid = isFormValid else { return }
            self.signupButton.isEnabled = isFormValid
            self.signupButton.backgroundColor = isFormValid ? .orange : .lightGray
        }
        
        signupViewModel.bindableImage.bind { [unowned self] (img) in
            self.selectPhotoButton.setImage(img?.withRenderingMode(.alwaysOriginal), for: .normal)
            self.selectPhotoButton.imageView?.contentMode = .scaleAspectFill
        }
        
        signupViewModel.bindableIsRegistering.bind { [unowned self] (isRegistering) in
            if isRegistering == true {
                self.showHUD()
            } else {
                SVProgressHUD.dismiss()
            }
        }
    }
    
    @objc fileprivate func handleSelectPhoto() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.editedImage] as? UIImage {
            signupViewModel.bindableImage.value = selectedImage
        }
        dismiss(animated: true)
    }
    
    @objc fileprivate func handleBack() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc fileprivate func handleTextChange(textField: UITextField) {
        
        if textField == firstNameTextField {
            signupViewModel.firstName = textField.text
        } else if textField == lastNameTextField {
            signupViewModel.lastName = textField.text
        } else if textField == emailTextField {
            signupViewModel.email = textField.text
        } else {
            signupViewModel.password = textField.text
        }
    }
    
    @objc fileprivate func handleSignup() {
        self.handleTapDismiss()
        signupViewModel.performSignUp { [weak self] (error) in
            if let error = error {
                self?.showHUDWithError(error: error)
                return
            } //FIXME - For some reason it repeats the following twice
            print("***Finished signing up user")
            self?.showSuccessHUD(withStatus: "welcome to the jungle")
            let newVC = OnboardingController()
            self?.navigationController?.pushViewController(newVC, animated: true)
        }
    }
    
    fileprivate func showHUD() {
        SVProgressHUD.show()
        SVProgressHUD.setDefaultMaskType(.gradient)
        SVProgressHUD.setHapticsEnabled(true)
    }
    
    fileprivate func showSuccessHUD(withStatus: String) {
        SVProgressHUD.setDefaultMaskType(.gradient)
        SVProgressHUD.setHapticsEnabled(true)
        SVProgressHUD.show(withStatus: withStatus)
        SVProgressHUD.dismiss(withDelay: 2)
    }
    
    fileprivate func showHUDWithError(error: Error) {
//        SVProgressHUD.dismiss()
        SVProgressHUD.setDefaultMaskType(.gradient)
        SVProgressHUD.setHapticsEnabled(true)
        SVProgressHUD.showError(withStatus: error.localizedDescription)
        SVProgressHUD.dismiss(withDelay: 3)
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
//        NotificationCenter.default.removeObserver(self)
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
    
    lazy var photoButtonStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [UIView(), selectPhotoButton, UIView()])
        sv.distribution = .equalCentering
        return sv
    }()
    
    lazy var stackView = UIStackView(arrangedSubviews: [
        logoText,
        photoButtonStackView,
        firstNameTextField,
        lastNameTextField,
        emailTextField,
        passwordTextField,
//        confirmPasswordTextField,
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
