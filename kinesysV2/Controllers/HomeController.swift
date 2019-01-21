//
//  ViewController.swift
//  kinesysV2
//
//  Created by Chris Davis on 1/19/19.
//  Copyright © 2019 Chris Davis. All rights reserved.
//

import UIKit

class HomeController: UITableViewController {
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        setupNavigationItems()

    }
    
    @objc func handleOpen() {
        (UIApplication.shared.keyWindow?.rootViewController as? BaseSlidingController)?.openMenu()
    }
    
    @objc func handleHide() {

    }
    
    //MARK:- fileprivate functions
    
    fileprivate func setupNavigationItems() {
        navigationItem.title = "Home"
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        setupCircularNavButton()
        
//        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "open", style: .plain, target: self, action: #selector(handleOpen))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "hide", style: .plain, target: self, action: #selector(handleHide))
    }
    
    fileprivate func setupCircularNavButton() {
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
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cellId")
        cell.textLabel?.text = "row"
        return cell
    }


}

