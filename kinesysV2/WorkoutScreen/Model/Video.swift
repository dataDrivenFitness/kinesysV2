//
//  Video.swift
//  kinesys
//
//  Created by Chris Davis on 1/14/19.
//  Copyright © 2019 Chris Davis. All rights reserved.
//

import UIKit

class Video: NSObject {
    
    var thumbnailImageName: String?
    var exerciseIcon: String?
    var title: String?
//    var subtitle: String?
    
    var phase: Phase?
    var progression: Progression?
    
}

class Phase: NSObject { // add sets, reps, rest
    var text: String?
    var sets: String?
    var reps: String?
    var rest: String?
}

class Progression: NSObject {
    var text: String?
}

