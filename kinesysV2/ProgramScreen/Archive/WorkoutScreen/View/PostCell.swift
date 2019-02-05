//
//  PostCell.swift
//  kinesys
//
//  Created by Chris Davis on 1/14/19.
//  Copyright © 2019 Chris Davis. All rights reserved.
//

import UIKit

class PostCell: BaseCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    let cellId = "cellId"
    
    var videos: [Video] = {
        
        var exercise1 = Video()
        exercise1.thumbnailImageName = "post1"
        exercise1.exerciseIcon = "bodyweightIcon"
        exercise1.title = "Static Stretch Hip Flexor"
        exercise1.subtitle = "Get ready to swing your ass off in this amazing cardio burning strength/power exercise"
        
        var exercise2 = Video()
        exercise2.thumbnailImageName = "post2"
        exercise2.exerciseIcon = "bodyweightIcon"
        exercise2.title = "Static Stretch Glutes"
        exercise2.subtitle = "Get ready to swing your ass off in this amazing cardio burning strength/power exercise"
        
        var exercise3 = Video()
        exercise3.thumbnailImageName = "post3"
        exercise3.exerciseIcon = "bodyweightIcon"
        exercise3.title = "Static Stretch Hamstring"
        exercise3.subtitle = "Get ready to swing your ass off in this amazing cardio burning strength/power exercise"
        
        return [exercise1, exercise2, exercise3]
        
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(collectionView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: collectionView)
        addConstraintsWithFormat(format: "V:|[v0]|", views: collectionView)
        
        collectionView.register(ExerciseCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ExerciseCell
        
        cell.video = videos[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (frame.width - 16 - 16) * 9 / 16
        return CGSize(width: frame.width, height: height + 16 + 88) //to change size of videoThumbnail
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
}
