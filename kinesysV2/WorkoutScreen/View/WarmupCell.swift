//
//  WarmupCell.swift
//  kinesys
//
//  Created by Chris Davis on 1/14/19.
//  Copyright © 2019 Chris Davis. All rights reserved.
//

import UIKit

class WarmupCell: BaseCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    let cellId = "cellId"
    
    var videos: [Video] = {
        
        var exercise1 = Video()
        exercise1.thumbnailImageName = "corrective1"
        exercise1.exerciseIcon = "foamRollerIcon"
        exercise1.title = "Foam Roller Piriformus"
        exercise1.subtitle = "Get ready to swing your ass off in this amazing cardio burning strength/power exercise"
        
        var exercise2 = Video()
        exercise2.thumbnailImageName = "corrective2"
        exercise2.exerciseIcon = "foamRollerIcon"
        exercise2.title = "Foam Roller Latissimus Doris"
        exercise2.subtitle = "Get ready to swing your ass off in this amazing cardio burning strength/power exercise"
        
        var exercise3 = Video()
        exercise3.thumbnailImageName = "corrective3"
        exercise3.exerciseIcon = "bodyweightIcon"
        exercise3.title = "Bodyweight Hip Bridge"
        exercise3.subtitle = "Get ready to swing your ass off in this amazing cardio burning strength/power exercise"
        
        var exercise4 = Video()
        exercise4.thumbnailImageName = "corrective4"
        exercise4.exerciseIcon = "foamRollerIcon"
        exercise4.title = "Foam Roller Calves"
        exercise4.subtitle = "Get ready to swing your ass off in this amazing cardio burning strength/power exercise"        
        
        return [exercise1, exercise2, exercise3, exercise4]
        
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let videoLauncher = VideoLauncher()
//        videoLauncher.showVideoPlayer()
        print("Play video launcher")
        let videoVC = UIViewController()
        videoVC.view.backgroundColor = .green
        let navController = UINavigationController()
        navController.pushViewController(videoVC, animated: true)
    }
    
}
