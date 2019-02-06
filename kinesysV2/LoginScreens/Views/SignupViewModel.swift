//
//  SignupViewModel.swift
//  kinesysV2
//
//  Created by Chris Davis on 1/30/19.
//  Copyright © 2019 Chris Davis. All rights reserved.
//

import UIKit
import Firebase

class SignupViewModel {
    
    var bindableImage = Bindable<UIImage>()
    var bindableIsFormValid = Bindable<Bool>()
    var bindableIsRegistering = Bindable<Bool>()
    
    var firstName: String? { didSet { checkFormValidity() } }
    var lastName: String? { didSet { checkFormValidity() } }
    var email: String? { didSet { checkFormValidity() } }
    var password: String? { didSet { checkFormValidity() } }
    
    func performSignUp(completion: @escaping (Error?) -> ()) {
        
        guard let email = email, let password = password else { return }
        bindableIsRegistering.value = true
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            
            if let error = error {
                completion(error)
                return
            }
            
            self.saveImageToFirebase(completion: completion)

        }
    }
    
    fileprivate func saveImageToFirebase(completion: @escaping (Error?) -> ()) {
        let filename = UUID().uuidString
        let ref = Storage.storage().reference(withPath: "/profileImage/\(filename)")
        let imageData = self.bindableImage.value?.jpegData(compressionQuality: 0.75) ?? Data()
        ref.putData(imageData, metadata: nil, completion: { (_, error) in
            if let error = error {
                completion(error)
                return
            }
            print("***finished uploading image to storage")
            ref.downloadURL(completion: { (url, error) in
                if let error = error {
                    completion(error)
                    return
                }
                self.bindableIsRegistering.value = false
                print("***Download url is: ", url?.absoluteString ?? "")
                let imageUrl = url?.absoluteString ?? ""
                self.saveInfoToFirestore(imageUrl: imageUrl, completion: completion)
                completion(nil)
            })
        })
    }
    
    fileprivate func saveInfoToFirestore(imageUrl: String ,completion: @escaping (Error?) -> ()) {
        let uid = Auth.auth().currentUser?.uid ?? ""
        let docData = [
            "firstName" : firstName ?? "",
            "lastName" : lastName ?? "",
            "uid" : uid,
            "profileImage" : imageUrl]
        Firestore.firestore().collection("users").document(uid).setData(docData) { (error) in
            if let error = error {
                completion(error)
                return
            }
            completion(nil)
        }
    }

    fileprivate func checkFormValidity() {
        let isFormValid = firstName?.isEmpty == false && lastName?.isEmpty == false && email?.isEmpty == false && password?.isEmpty == false
        bindableIsFormValid.value = isFormValid
    }
}
