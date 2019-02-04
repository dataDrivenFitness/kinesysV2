//
//  WelcomeScreenView.swift
//  kinesysV2
//
//  Created by Chris Davis on 2/3/19.
//  Copyright © 2019 Chris Davis. All rights reserved.
//

import UIKit

class WelcomeScreenView: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
        
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        
        cv.isPagingEnabled = true
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    let backgroundImageView: UIImageView = {
        let v = UIImageView()
        v.image = #imageLiteral(resourceName: "assess1")
        v.contentMode = .scaleAspectFill
        return v
    }()
    
    let darkView: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor(white: 0, alpha: 0.65)
        return v
    }()
    
    let pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.pageIndicatorTintColor = UIColor.darkGray
        pc.currentPageIndicatorTintColor = .white
        pc.numberOfPages = 4
        return pc
    }()
    
    let firstCellId = "firstCellId"
    let secondCellId = "secondCellId"
    let thirdCellId = "thirdCellId"
    let fourthCellId = "fourthCellId"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        
        setupRegistration()

        setupPageControl()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 0 {
            let firstCell = collectionView.dequeueReusableCell(withReuseIdentifier: firstCellId, for: indexPath)
            return firstCell
        } else if indexPath.item == 1 {
            let secondCell = collectionView.dequeueReusableCell(withReuseIdentifier: secondCellId, for: indexPath)
            return secondCell
        } else if indexPath.item == 2 {
            let thirdCell = collectionView.dequeueReusableCell(withReuseIdentifier: thirdCellId, for: indexPath)
            return thirdCell
        } else {
            let fourthCell = collectionView.dequeueReusableCell(withReuseIdentifier: fourthCellId, for: indexPath)
            return fourthCell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width, height: frame.height)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let pageNumber = Int(targetContentOffset.pointee.x / frame.width)
        pageControl.currentPage = pageNumber
    }
    
    fileprivate func setupRegistration() {
        collectionView.register(FirstPageCell.self, forCellWithReuseIdentifier: firstCellId)
        collectionView.register(SecondPageCell.self, forCellWithReuseIdentifier: secondCellId)
        collectionView.register(ThirdPageCell.self, forCellWithReuseIdentifier: thirdCellId)
        collectionView.register(FourthPageCell.self, forCellWithReuseIdentifier: fourthCellId)
    }
    
    fileprivate func setupViews() {
        collectionView.showsHorizontalScrollIndicator = false
        
        addSubview(backgroundImageView)
        backgroundImageView.fillSuperview()
        
        addSubview(darkView)
        darkView.fillSuperview()
        
        addSubview(collectionView)
        collectionView.fillSuperview()
    }
    
    fileprivate func setupPageControl() {
        addSubview(pageControl)
        _ = pageControl.anchor(nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 50)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
