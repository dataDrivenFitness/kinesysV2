//
//  AssessmentCell.swift
//  kinesysV2
//
//  Created by Chris Davis on 1/23/19.
//  Copyright © 2019 Chris Davis. All rights reserved.
//

import UIKit

class AssessmentCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .green
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
