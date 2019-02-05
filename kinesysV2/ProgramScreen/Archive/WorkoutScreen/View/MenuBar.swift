//
//  MenuBar.swift
//  kinesys
//
//  Created by Chris Davis on 1/13/19.
//  Copyright © 2019 Chris Davis. All rights reserved.
//

import UIKit

class MenuBar: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    let cellId = "cellId"
    let imageNames = ["homeIcon", "fireIcon" , "calendarIcon", "accountIcon"]
    
    var workoutController: WorkoutController?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        collectionView.register(MenuCell.self, forCellWithReuseIdentifier: cellId)
        
        addSubview(collectionView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: collectionView)
        addConstraintsWithFormat(format: "V:|[v0]|", views: collectionView)
        
        let selectedIndexPath = NSIndexPath(item: 0, section: 0)
        collectionView.selectItem(at: selectedIndexPath as IndexPath, animated: false, scrollPosition: [])
        
        setupHorizontalBar()
        
    }
    var horizontalBarLeftAnchorConstraint: NSLayoutConstraint?
    
    func setupHorizontalBar() {
        let horizontalBarView = UIView()
        horizontalBarView.backgroundColor = UIColor.darkGray
        horizontalBarView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(horizontalBarView)
        
        horizontalBarLeftAnchorConstraint = horizontalBarView.leftAnchor.constraint(equalTo: self.leftAnchor)
        horizontalBarLeftAnchorConstraint?.isActive = true
        
        horizontalBarView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        horizontalBarView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/4).isActive = true
        horizontalBarView.heightAnchor.constraint(equalToConstant: 3).isActive = true
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        workoutController?.scrollToMenuIndex(menuIndex: indexPath.item)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MenuCell
        
        cell.imageView.image = UIImage(named: imageNames[indexPath.item])?.withRenderingMode(.alwaysTemplate)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width / 4, height: frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
