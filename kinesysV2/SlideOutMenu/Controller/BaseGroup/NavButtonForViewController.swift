//
//  NavigationButtonController.swift
//  kinesysV2
//
//  Created by Chris Davis on 1/20/19.
//  Copyright © 2019 Chris Davis. All rights reserved.
//

import UIKit
import SDWebImage
import Firebase

class NavButtonForViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCircularNavButton()
        setupChatButtons()
    }
    
    @objc func handleOpen() {
        (UIApplication.shared.keyWindow?.rootViewController as? BaseSlidingController)?.openMenu()
    }
    
    @objc fileprivate func handleChat() {
        let chatVC = UIViewController()
        chatVC.view.backgroundColor = .orange
        chatVC.title = "Direct Message"
        navigationController?.pushViewController(chatVC, animated: true)
    }
    
    @objc fileprivate func handleSocial() {
        let socialVC = UIViewController()
        socialVC.view.backgroundColor = .green
        socialVC.title = "Social Media Section"
        navigationController?.pushViewController(socialVC, animated: true)
    }
    
    var user: User?
    
    func setupCircularNavButton() { // need to refactor this - duplication
        
        let image = #imageLiteral(resourceName: "alexOC_profile").withRenderingMode(.alwaysOriginal)
        let customView = UIButton(type: .system)
        let iconSize: CGFloat = 30
        customView.addTarget(self, action: #selector(handleOpen), for: .touchUpInside)
        customView.setImage(image, for: .normal)
        customView.imageView?.contentMode = .scaleAspectFit
        customView.layer.cornerRadius = iconSize / 2
        customView.clipsToBounds = true
        customView.widthAnchor.constraint(equalToConstant: iconSize).isActive = true
        customView.heightAnchor.constraint(equalToConstant: iconSize).isActive = true
        let barButtonItem = UIBarButtonItem(customView: customView)
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        Firestore.firestore().collection("users").document(uid).getDocument { (snapshot, error) in
            if let error = error {
                print(error)
                return
            }
            guard let dictionary = snapshot?.data() else { return }
            self.user = User(dictionary: dictionary)
            
            guard let imageUrl = self.user?.profileImage, let url = URL(string: imageUrl) else { return }
            SDWebImageManager.shared().loadImage(with: url, options: .continueInBackground, progress: nil) { (image, _, _, _, _, _) in
                customView.setImage(image?.withRenderingMode(.alwaysOriginal), for: .normal)
            }
            
            self.view.reloadInputViews()
        }
        
        navigationItem.leftBarButtonItem = barButtonItem
        
    }
    
    func setupChatButtons () {
        
        let iconSize: CGFloat = 25
        
        let chatImage = #imageLiteral(resourceName: "lists").withRenderingMode(.alwaysTemplate)
        let chatCustomView = UIButton(type: .system)
        chatCustomView.addTarget(self, action: #selector(handleChat), for: .touchUpInside)
        chatCustomView.setImage(chatImage, for: .normal)
        chatCustomView.tintColor = UIColor.darkGray
        chatCustomView.widthAnchor.constraint(equalToConstant: iconSize).isActive = true
        chatCustomView.heightAnchor.constraint(equalToConstant: iconSize).isActive = true
        let chatButtonItem = UIBarButtonItem(customView: chatCustomView)
        
        let image = #imageLiteral(resourceName: "profile").withRenderingMode(.alwaysTemplate)
        let customView = UIButton(type: .system)
        customView.addTarget(self, action: #selector(handleSocial), for: .touchUpInside)
        customView.setImage(image, for: .normal)
        customView.tintColor = UIColor.darkGray
        customView.widthAnchor.constraint(equalToConstant: iconSize).isActive = true
        customView.heightAnchor.constraint(equalToConstant: iconSize).isActive = true
        let socialButtonItem = UIBarButtonItem(customView: customView)
        
        navigationItem.rightBarButtonItems = [chatButtonItem, socialButtonItem]
        
    }
    
    func setTitleLabel(text: String){
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        titleLabel.text = text
        titleLabel.textColor = UIColor.darkGray
        titleLabel.font = UIFont(name: "Avenir-Light", size: 24)
        navigationItem.titleView = titleLabel
        navigationController?.navigationBar.isTranslucent = false
        
    }
    
    fileprivate func fetchCurrentUser() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        Firestore.firestore().collection("users").document(uid).getDocument { (snapshot, error) in
            if let error = error {
                print(error)
                return
            }
            guard let dictionary = snapshot?.data() else { return }
            self.user = User(dictionary: dictionary)
            self.view.reloadInputViews()
        }
    }
}
