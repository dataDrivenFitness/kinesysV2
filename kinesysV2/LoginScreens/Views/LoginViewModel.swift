//
//  LoginViewModel.swift
//  kinesysV2
//
//  Created by Chris Davis on 1/21/19.
//  Copyright © 2019 Chris Davis. All rights reserved.
//

import UIKit

class LoginViewModel {
    
    var email: String? { didSet { checkFormValidity() } }
    var password: String? { didSet { checkFormValidity() } }
    
    fileprivate func checkFormValidity() {
        let isFormValid = email?.isEmpty == false && password?.isEmpty == false
        isFormValidObserver?(isFormValid)
    }
    
    // Reactive programming
    var isFormValidObserver: ((Bool) -> ())?
    
}
