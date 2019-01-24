//
//  NavigationButtonController.swift
//  kinesysV2
//
//  Created by Chris Davis on 1/20/19.
//  Copyright © 2019 Chris Davis. All rights reserved.
//

import UIKit

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
//        let chat = UIViewController()
//        navigationController?.isNavigationBarHidden = true
//        chat.view.backgroundColor = .orange
//        navigationController?.pushViewController(chat, animated: true)
    }
    
    @objc fileprivate func handleSocial() {
        
    }
    
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
        
        navigationItem.leftBarButtonItem = barButtonItem
        
    }
    
    func setupChatButtons () {
        
        let iconSize: CGFloat = 25
        
        let chatImage = #imageLiteral(resourceName: "lists").withRenderingMode(.alwaysTemplate)
        let chatCustomView = UIButton(type: .system)
        chatCustomView.addTarget(self, action: #selector(handleChat), for: .touchUpInside)
        chatCustomView.setImage(chatImage, for: .normal)
        chatCustomView.tintColor = .orange
        chatCustomView.widthAnchor.constraint(equalToConstant: iconSize).isActive = true
        chatCustomView.heightAnchor.constraint(equalToConstant: iconSize).isActive = true
        let chatButtonItem = UIBarButtonItem(customView: chatCustomView)
        
        let image = #imageLiteral(resourceName: "profile").withRenderingMode(.alwaysTemplate)
        let customView = UIButton(type: .system)
        customView.addTarget(self, action: #selector(handleSocial), for: .touchUpInside)
        customView.setImage(image, for: .normal)
        customView.tintColor = .orange
        customView.widthAnchor.constraint(equalToConstant: iconSize).isActive = true
        customView.heightAnchor.constraint(equalToConstant: iconSize).isActive = true
        let socialButtonItem = UIBarButtonItem(customView: customView)
        
        navigationItem.rightBarButtonItems = [chatButtonItem, socialButtonItem]
        
    }
    
    func setTitleLabel(text: String){
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        titleLabel.text = text
        titleLabel.textColor = UIColor.orange
        titleLabel.font = UIFont(name: "Avenir-Light", size: 24)
        navigationItem.titleView = titleLabel
        navigationController?.navigationBar.isTranslucent = false
    }
}
