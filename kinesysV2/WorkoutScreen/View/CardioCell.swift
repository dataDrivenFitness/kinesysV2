//
//  CardioCell.swift
//  kinesys
//
//  Created by Chris Davis on 1/14/19.
//  Copyright © 2019 Chris Davis. All rights reserved.
//

import UIKit

class CardioCell: BaseCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    let cellId = "cellId"
    
    var videos: [Video] = {
        
        var phase = Phase()
        phase.text = "cardio str @ 5-10% incline"
        phase.sets = "6-8"
        phase.reps = "mid:lo:hi - 2:1:1"
        phase.rest = "60 sec"
        
        var phase2 = Phase()
        phase2.text = "cardio power"
        phase2.sets = "10"
        phase2.reps = "hi:lo - 2:1"
        phase2.rest = "0 sec"

        var progression = Progression()
        progression.text = "n/a"
        
        var exercise1 = Video()
        exercise1.thumbnailImageName = "treadmill"
        exercise1.exerciseIcon = "treadmillIcon"
        exercise1.title = "Treadmill Strength Run"
        exercise1.phase = phase
        exercise1.progression = progression
        
        var exercise2 = Video()
        exercise2.thumbnailImageName = "rower"
        exercise2.exerciseIcon = "treadmillIcon"
        exercise2.title = "Rower Sprints"
        exercise2.phase = phase2
        exercise2.progression = progression

        
        return [exercise1, exercise2]
        
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
