//
//  MenuController.swift
//  kinesysV2
//
//  Created by Chris Davis on 1/19/19.
//  Copyright © 2019 Chris Davis. All rights reserved.
//

import UIKit

struct MenuItem {
    let icon: UIImage
    let title: String
}

extension MenuController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let slidingController = UIApplication.shared.keyWindow?.rootViewController as? BaseSlidingController
        slidingController?.didSelectMenuItem(indexPath: indexPath)
        
    }
}

class MenuController: UITableViewController {
    
    let menuItems = [
        MenuItem(icon: #imageLiteral(resourceName: "bookmarks").withRenderingMode(.alwaysTemplate), title: "home"),
        MenuItem(icon: #imageLiteral(resourceName: "moments").withRenderingMode(.alwaysTemplate), title: "today's workout"),
        MenuItem(icon: #imageLiteral(resourceName: "lists").withRenderingMode(.alwaysTemplate), title: "history"),
        MenuItem(icon: #imageLiteral(resourceName: "bookmarks").withRenderingMode(.alwaysTemplate), title: "setting"),
        MenuItem(icon: #imageLiteral(resourceName: "help").withRenderingMode(.alwaysTemplate), title: "help"),
        MenuItem(icon: #imageLiteral(resourceName: "cancel").withRenderingMode(.alwaysTemplate), title: "logout")
    ]
    
    let socialStackView = UIStackView(arrangedSubviews: [
        
        ])

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .none
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = MenuItemCell(style: .default, reuseIdentifier: "cellId")
        let menuItem = menuItems[indexPath.row]
        cell.iconImageView.image  = menuItem.icon
        cell.titleLabel.text = menuItem.title

        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let customHeaderView = CustomMenuHeaderView()
        return customHeaderView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 200
    }

}
