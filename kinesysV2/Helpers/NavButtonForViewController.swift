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
    }
    
    @objc func handleOpen() {
        (UIApplication.shared.keyWindow?.rootViewController as? BaseSlidingController)?.openMenu()
    }
    
    @objc func handleHide() {
        
    }
    
    func setupCircularNavButton() { // need to refactor this - duplication
        let image = #imageLiteral(resourceName: "alexOC_profile").withRenderingMode(.alwaysOriginal)
        let customView = UIButton(type: .system)
        customView.addTarget(self, action: #selector(handleOpen), for: .touchUpInside)
        customView.setImage(image, for: .normal)
        customView.imageView?.contentMode = .scaleAspectFit
        customView.layer.cornerRadius = 20
        customView.clipsToBounds = true
        customView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        customView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        let barButtonItem = UIBarButtonItem(customView: customView)
        
        navigationItem.leftBarButtonItem = barButtonItem
        
    }
    
    func setupCircularChatButton () {
        
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
