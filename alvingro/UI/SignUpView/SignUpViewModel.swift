//
//  SignUpViewModel.swift
//  alvingro
//
//  Created by Thành Nguyên on 17/05/2021.
//

import Foundation
import Firebase
import FirebaseFirestore

protocol SignUpViewModelEvents: AnyObject {
    func signUpSuccess()
    func signUpFailed(error: Error)
}

class SignUpViewModel {
    weak var delegate: SignUpViewModelEvents?
    
    init(delegate: SignUpViewModelEvents) {
        self.delegate = delegate
    }
    
    func signUp(email: String, password: String) {
        
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
            guard let strongSelf = self else { return }
            if let error = error {
                strongSelf.delegate?.signUpFailed(error: error)
            } else {
                // Sign up successful
                strongSelf.createUserDataOnFirebase()
                strongSelf.delegate?.signUpSuccess()
            }
        }
    }
    
    func createUserDataOnFirebase(){
        let db = Firestore.firestore()
        
        if let user = Auth.auth().currentUser {
            User.current.login(id: user.uid, name: nil, address: nil, email: user.email, phone: nil, isManager: false, photo: nil)
            do {
                let encoder = JSONEncoder()
                let jsonData = try encoder.encode(User.current)
                guard let json = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String : Any] else { return }
                db.collection("User").document(user.uid).setData(json)
            } catch let error {
                print("Log in error: \(error)")
            }
            createLocalUser()
        }
    }
    
    func createLocalUser() {
        LocalDatabase.shared.removeObjects(ofType: User.self)
        LocalDatabase.shared.set(User.current)
    }
}


