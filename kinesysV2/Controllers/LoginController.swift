//
//  LoginController.swift
//  kinesysV2
//
//  Created by Chris Davis on 1/21/19.
//  Copyright © 2019 Chris Davis. All rights reserved.
//

import UIKit

class LoginController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        navigationController?.isNavigationBarHidden = true
        view.backgroundColor = .red
        setupCircularNavButton()
        
    }
    
    func setupCircularNavButton() { // need to refactor this - duplication
        let image = #imageLiteral(resourceName: "alexOC_profile").withRenderingMode(.alwaysOriginal)
        let customView = UIButton(type: .system)
        customView.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        customView.setImage(image, for: .normal)
        customView.imageView?.contentMode = .scaleAspectFit
        customView.layer.cornerRadius = 20
        customView.clipsToBounds = true
        customView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        customView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        let barButtonItem = UIBarButtonItem(customView: customView)
        
        navigationItem.rightBarButtonItem = barButtonItem
        
    }
    
    @objc func handleLogin() {
        dismiss(animated: true, completion: nil)
    }
    
    
}
