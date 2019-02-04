//
//  WorkoutController.swift
//  kinesys
//
//  Created by Chris Davis on 1/13/19.
//  Copyright © 2019 Chris Davis. All rights reserved.
//

import UIKit

//***NEED TO MAKE THIS NAVIGATION CONTROLLER
class WorkoutController: NavButtonForViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    lazy var workoutCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    let lineSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray

        return view
    }()
    
    let cellId = "cellId" // WarmUpCell
    let strengthCellId = "strengthCellId"
    let cardioCellId = "cardioCellId"
    let postWorkoutCellId = "postWorkoutCellId"
    let titles =  ["warm up", "strength training", "cardio training", "post workout"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        navigationController?.navigationBar.prefersLargeTitles = true
        
        workoutCollectionView.showsHorizontalScrollIndicator = false
        workoutCollectionView.isScrollEnabled = false
        
        setTitleLabel(text: titles[0])
                
        view.addSubview(workoutCollectionView)
        
        setupCollectionView()
        setUpMenuBar()
    }
   
    func setupCollectionView() {
        if let flowLayout = workoutCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumLineSpacing = 0
        }
        
        workoutCollectionView.fillSuperview()
        
        workoutCollectionView.register(WarmupCell.self, forCellWithReuseIdentifier: cellId)
        workoutCollectionView.register(StrengthCell.self, forCellWithReuseIdentifier: strengthCellId)
        workoutCollectionView.register(CardioCell.self, forCellWithReuseIdentifier: cardioCellId)
        workoutCollectionView.register(PostCell.self, forCellWithReuseIdentifier: postWorkoutCellId)

        workoutCollectionView.contentInset = UIEdgeInsets(top: 100, left: 0, bottom: 0, right: 0)
        workoutCollectionView.scrollIndicatorInsets = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        
        workoutCollectionView.isPagingEnabled = true
    }
    
    func scrollToMenuIndex (menuIndex: Int) {
        let indexPath = NSIndexPath(item: menuIndex, section: 0)
        workoutCollectionView.scrollToItem(at: indexPath as IndexPath, at: [], animated: true)
        setTitleForIndex(index: menuIndex)
    }
    
    private func setTitleForIndex(index: Int) {
        if let titleLable = navigationItem.titleView as? UILabel {
            titleLable.text = titles[Int(index)]
        }
    }
    
    lazy var menuBar: MenuBar = {
        let mb = MenuBar()
        mb.workoutController = self
        return mb
    }()
    
    private func setUpMenuBar() {
        view.addSubview(menuBar)
        view.addSubview(lineSeparatorView)

        lineSeparatorView.anchorToTop(top: nil, left: view.leftAnchor, bottom: menuBar.topAnchor, right: view.rightAnchor)
        lineSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
//        view.addConstraintsWithFormat(format: "H:|[v0]|", views: menuBar)
//        view.addConstraintsWithFormat(format: "V:|[v0(50)]", views: menuBar)
        _ = menuBar.anchor(view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: view.frame.width, heightConstant: 50)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        menuBar.horizontalBarLeftAnchorConstraint?.constant = scrollView.contentOffset.x / 4
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let index = targetContentOffset.pointee.x / view.frame.width //used to be targetContentOffset.memory.x
        let indexPath = NSIndexPath(item: Int(index), section: 0)
        menuBar.collectionView.selectItem(at: indexPath as IndexPath, animated: true, scrollPosition: [])
        
        setTitleForIndex(index: Int(index))
    }
    
    //Need to make dynamic, allowing for 2-5 columns depending on number of sections in workout
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let identifier: String
        
        if indexPath.item == 1 {
            identifier = strengthCellId
        } else if indexPath.item == 2 {
            identifier = cardioCellId
        } else if indexPath.item == 3 {
            identifier = postWorkoutCellId
        } else {
            identifier = cellId
        }

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
}
