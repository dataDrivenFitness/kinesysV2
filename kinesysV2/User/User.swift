//
//  User.swift
//  SwipeMatchFirestoreLBTA
//
//  Created by Brian Voong on 11/3/18.
//  Copyright © 2018 Brian Voong. All rights reserved.
//

import UIKit

struct User {
    
    // defining our properties for our model layer
    var firstName: String?
    var lastName: String?
    var profileImage: String?
    var uid: String?
    
    init(dictionary: [String: Any]) {
        // we'll initialize our user here
        self.firstName = dictionary["firstName"] as? String ?? ""
        self.lastName = dictionary["lastName"] as? String ?? ""
        self.profileImage = dictionary["profileImage"] as? String ?? ""
        self.uid = dictionary["uid"] as? String ?? ""
    }
}


