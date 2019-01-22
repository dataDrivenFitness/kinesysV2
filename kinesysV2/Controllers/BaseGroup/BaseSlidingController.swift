//
//  BaseSlidingController.swift
//  kinesysV2
//
//  Created by Chris Davis on 1/19/19.
//  Copyright © 2019 Chris Davis. All rights reserved.
//

import UIKit
import Firebase

class MainContainerView: UIView {}
class LeftContainerView: UIView {}
class DarkCoverView: UIView {}

class BaseSlidingController: UIViewController, LoginControllerDelegate {
        
    let mainView: MainContainerView = {
        let v = MainContainerView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let leftMenuView: LeftContainerView = {
        let v = LeftContainerView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let darkCoverView: DarkCoverView = {
        let v = DarkCoverView()
        v.backgroundColor = UIColor(white: 0, alpha: 0.7)
        v.alpha = 0
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupViews()
        
        // how do we translate our red view
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        view.addGestureRecognizer(panGesture)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapDismiss))
        darkCoverView.addGestureRecognizer(tapGesture)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("HomeController did appear")
        // you want to kick the user out when they log out
        if Auth.auth().currentUser == nil {
            let loginController = LoginController()
            loginController.delegate = self
            let navController = UINavigationController(rootViewController: loginController)
            present(navController, animated: true)
        }
    }
    func didFinishLoggingIn() {
        fetchCurrentUser()
    }
    
    @objc func handleTapDismiss() {
        closeMenu()
    }
    
    @objc func handlePan(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        var x = translation.x
        
        x = isMenuOpened ? x + menuWidth : x
        x = min(menuWidth, x)
        x = max(0, x)
        
        mainViewLeadingConstraint.constant = x
        mainViewTrailingConstraint.constant = x
        darkCoverView.alpha = x / menuWidth
        
        if gesture.state == .ended {
            handleEnded(gesture: gesture)
        }
    }
    
    fileprivate func fetchCurrentUser() {
        print("fetching current user")
    }
    
    fileprivate func handleEnded(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        let velocity = gesture.velocity(in: view)
        
        if isMenuOpened {
            if velocity.x < -velocityThreshold {
                closeMenu()
                return
            }
            if abs(translation.x) < menuWidth / 2 {
                openMenu()
            } else {
                closeMenu()
            }
        } else {
            if velocity.x > velocityThreshold {
                openMenu()
                return
            }
            
            if translation.x < menuWidth / 2 {
                closeMenu()
            } else {
                openMenu()
            }
        }
    }
    
    func openMenu() {
        isMenuOpened = true
        mainViewLeadingConstraint.constant = menuWidth
        mainViewTrailingConstraint.constant = menuWidth
        performAnimations()
    }
    
    func closeMenu() {
        mainViewLeadingConstraint.constant = 0
        mainViewTrailingConstraint.constant = 0
        isMenuOpened = false
        performAnimations()
    }
    
    fileprivate func performLogout() {
        
        try? Auth.auth().signOut()
        let loginController = LoginController()
        let navController = UINavigationController(rootViewController: loginController)
        present(navController, animated: true)
        mainViewController = UINavigationController(rootViewController: HomeController())
    }
    
    func didSelectMenuItem(indexPath: IndexPath) {
        performMainViewCleanup()
        closeMenu()

        switch indexPath.row {
        case 0 :
            mainViewController = UINavigationController(rootViewController: HomeController())
        case 1:
            mainViewController = UINavigationController(rootViewController: WorkoutController())
        case 2:
            mainViewController = UINavigationController(rootViewController: CalendarController())
        case 3:
            mainViewController = UINavigationController(rootViewController: SettingController())
        case 4:
            mainViewController = UINavigationController(rootViewController: HelpController())
        default:
            performLogout()
        }
        
        mainView.addSubview(mainViewController.view)
        addChild(mainViewController)
        mainView.bringSubviewToFront(darkCoverView)
    }
    
    
    var mainViewController: UIViewController = UINavigationController(rootViewController: HomeController())
    let menuController = MenuController()


    fileprivate func performMainViewCleanup() {
        mainViewController.view.removeFromSuperview()
        mainViewController.removeFromParent()
    }
    
    fileprivate func performAnimations() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
            self.darkCoverView.alpha = self.isMenuOpened ? 1 : 0
        })
    }
    
    var mainViewLeadingConstraint: NSLayoutConstraint!
    var mainViewTrailingConstraint: NSLayoutConstraint!
    fileprivate let menuWidth: CGFloat = 300
    fileprivate let velocityThreshold: CGFloat = 500
    fileprivate var isMenuOpened = false
    
    fileprivate func setupViews() {
        view.addSubview(mainView)
        view.addSubview(leftMenuView)
        
        // let's go ahead and use Auto Layout
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: view.topAnchor),
            mainView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            leftMenuView.topAnchor.constraint(equalTo: view.topAnchor),
            leftMenuView.trailingAnchor.constraint(equalTo: mainView.leadingAnchor),
            leftMenuView.widthAnchor.constraint(equalToConstant: menuWidth),
            leftMenuView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor)
            ])
        
        mainViewLeadingConstraint = mainView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        mainViewLeadingConstraint.isActive = true
        
        mainViewTrailingConstraint = mainView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        mainViewTrailingConstraint.isActive = true
        
        setupViewControllers()
    }
    
    fileprivate func setupViewControllers() {
        
        let homeView = mainViewController.view!
        let menuView = menuController.view!
        
        homeView.translatesAutoresizingMaskIntoConstraints = false
        menuView.translatesAutoresizingMaskIntoConstraints = false
        
        mainView.addSubview(homeView)
        mainView.addSubview(darkCoverView)
        leftMenuView.addSubview(menuView)
        
        NSLayoutConstraint.activate([
            // top, leading, bottom, trailing anchors
            homeView.topAnchor.constraint(equalTo: mainView.topAnchor),
            homeView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
            homeView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor),
            homeView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
            
            menuView.topAnchor.constraint(equalTo: leftMenuView.topAnchor),
            menuView.leadingAnchor.constraint(equalTo: leftMenuView.leadingAnchor),
            menuView.bottomAnchor.constraint(equalTo: leftMenuView.bottomAnchor),
            menuView.trailingAnchor.constraint(equalTo: leftMenuView.trailingAnchor),
            
            darkCoverView.topAnchor.constraint(equalTo: mainView.topAnchor),
            darkCoverView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
            darkCoverView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor),
            darkCoverView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
            ])
        
        addChild(mainViewController)
        addChild(menuController)
    }
    
}
