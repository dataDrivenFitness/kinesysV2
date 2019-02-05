//
//  SettingController.swift
//  kinesysV2
//
//  Created by Chris Davis on 1/20/19.
//  Copyright © 2019 Chris Davis. All rights reserved.
//

import UIKit
import Firebase

class SettingController: UITableViewController {
    
    let profilePictureButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("select photo", for: .normal)
        button.backgroundColor = .white
        button.contentMode = .scaleAspectFit
        button.layer.cornerRadius = 200 / 2
        button.clipsToBounds = true
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationItems()
        
        tableView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        tableView.separatorStyle = .none
        
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView()
        header.backgroundColor = .blue
        header.addSubview(profilePictureButton)
        profilePictureButton.anchor(top: header.topAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 25, left: 0, bottom: 0, right: 0), size: .init(width: 200, height: 200))
        profilePictureButton.centerXAnchor.constraint(equalTo: header.centerXAnchor).isActive = true
        return header
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 250
    }
    
    fileprivate func setupNavigationItems() {
        navigationItem.title = "Settings"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(handleSave))
        
    }
    
    @objc fileprivate func handleCancel() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc fileprivate func handleSave() {
        dismiss(animated: true, completion: nil)
    }

}
