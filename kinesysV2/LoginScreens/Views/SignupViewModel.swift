//
//  SignupViewModel.swift
//  kinesysV2
//
//  Created by Chris Davis on 1/30/19.
//  Copyright © 2019 Chris Davis. All rights reserved.
//

import UIKit

class SignupViewModel {
    
    var email: String? { didSet { checkFormValidity() } }
    var password: String? { didSet { checkFormValidity() } }
    var verifyPassword: String? { didSet { checkFormValidity() } }

    
    fileprivate func checkFormValidity() {
        let isFormValid = email?.isEmpty == false && password?.isEmpty == false && verifyPassword?.isEmpty == false
        isFormValidObserver?(isFormValid)
    }
    
    // Reactive programming
    var isFormValidObserver: ((Bool) -> ())?
    
}
