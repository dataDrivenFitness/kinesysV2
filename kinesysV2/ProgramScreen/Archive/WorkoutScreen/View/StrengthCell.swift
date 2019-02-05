//
//  StrengthCell.swift
//  kinesys
//
//  Created by Chris Davis on 1/14/19.
//  Copyright © 2019 Chris Davis. All rights reserved.
//

import UIKit

class StrengthCell: BaseCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    let cellId = "cellId"
    
    var videos: [Video] = {
        
        var exercise1 = Video()
        exercise1.thumbnailImageName = "kbImage1"
        exercise1.exerciseIcon = "kbIcon"
        exercise1.title = "Kettlebell Front Swing"
        exercise1.subtitle = "Get ready to swing your ass off in this amazing cardio burning strength/power exercise"
        
        var exercise2 = Video()
        exercise2.thumbnailImageName = "kbImage2"
        exercise2.exerciseIcon = "kbIcon"
        exercise2.title = "Kettlebell Single Arm Clean"
        exercise2.subtitle = "Get ready to swing your ass off in this amazing cardio burning strength/power exercise"
        
        var exercise3 = Video()
        exercise3.thumbnailImageName = "kbImage3"
        exercise3.exerciseIcon = "kbIcon"
        exercise3.title = "Kettlebell Turkish Get Up"
        exercise3.subtitle = "Get ready to swing your ass off in this amazing cardio burning strength/power exercise"
        
        var exercise4 = Video()
        exercise4.thumbnailImageName = "kbImage4"
        exercise4.exerciseIcon = "kbIcon"
        exercise4.title = "Kettlebell Single Leg Deadlift"
        exercise4.subtitle = "Get ready to swing your ass off in this amazing cardio burning strength/power exercise"
        
        var exercise5 = Video()
        exercise5.thumbnailImageName = "kbImage5"
        exercise5.exerciseIcon = "kbIcon"
        exercise5.title = "Kettlebell Single Goblet Squat"
        exercise5.subtitle = "Get ready to swing your ass off in this amazing cardio burning strength/power exercise"
        
        return [exercise1, exercise2, exercise3, exercise4, exercise5]
        
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
