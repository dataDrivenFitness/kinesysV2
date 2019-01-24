//
//  ViewController.swift
//  kinesysV2
//
//  Created by Chris Davis on 1/19/19.
//  Copyright © 2019 Chris Davis. All rights reserved.
//

import UIKit

class HomeController: NavButtonForViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.dataSource = self
        cv.delegate = self
        cv.isPagingEnabled = true
        return cv
    }()
    
    let pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.pageIndicatorTintColor = UIColor.lightGray
        pc.currentPageIndicatorTintColor = .orange
        pc.numberOfPages = 3
        return pc
    }()
    
    let cellId = "cellId"
    let progressId = "progressId"
    let assessmentId = "assessmentId"
    let titles = ["home", "progress", "assessment"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.showsHorizontalScrollIndicator = false
        
        setTitleLabel(text: titles[0])
        view.addSubview(collectionView)
        collectionView.fillSuperview()
        
        registerCells()
        
        view.addSubview(pageControl)
        _ = pageControl.anchor(nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 50)
        
    }
    func scrollToMenuIndex (menuIndex: Int) {
        let indexPath = NSIndexPath(item: menuIndex, section: 0)
        collectionView.scrollToItem(at: indexPath as IndexPath, at: [], animated: true)
        setTitleForIndex(index: menuIndex)
    }
    
    private func setTitleForIndex(index: Int) {
        if let titleLable = navigationItem.titleView as? UILabel {
            titleLable.text = titles[Int(index)]
        }
    }
    
    fileprivate func registerCells() {
        collectionView.register(HomeCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(ProgressCell.self, forCellWithReuseIdentifier: progressId)
        collectionView.register(AssessmentCell.self, forCellWithReuseIdentifier: assessmentId)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let pageNumber = Int(targetContentOffset.pointee.x / view.frame.width)
        pageControl.currentPage = pageNumber
        
        let indexPath = IndexPath(item: pageNumber, section: 0)
        setTitleForIndex(index: indexPath.item)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.item == 0 {
            let homeCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
            return homeCell
        } else if indexPath.item == 1 {
            let progressCell = collectionView.dequeueReusableCell(withReuseIdentifier: progressId, for: indexPath)
            return progressCell
        } else {
            let assessmentCell = collectionView.dequeueReusableCell(withReuseIdentifier: assessmentId, for: indexPath)
            return assessmentCell
        }
    }
}

