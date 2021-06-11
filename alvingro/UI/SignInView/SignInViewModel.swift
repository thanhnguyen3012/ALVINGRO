//
//  SignInViewModel.swift
//  alvingro
//
//  Created by Thành Nguyên on 17/05/2021.
//

import Foundation
import Firebase
import FirebaseFirestore

protocol SignInViewModelEvents: AnyObject {
    func signInSuccess()
    func signInFailed(error: Error)
}

class SignInViewModel {
    
    weak var delegate: SignInViewModelEvents?
    
    init(delegate: SignInViewModelEvents) {
        self.delegate = delegate
    }
    
    func signIn(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            guard let strongSelf = self else { return }
            if let error = error {
                strongSelf.delegate?.signInFailed(error: error)
            } else {
                //Log in successful
                strongSelf.getUserInfoFromFirebase()
            }
        }
    }
    
    func checkCurrentAccount() {
        if  ((Auth.auth().currentUser != nil) && ((LocalDatabase.shared.getAnObject(key: "id", value: Auth.auth().currentUser?.uid ?? "" , ofType: User.self)) != nil)) {
            delegate?.signInSuccess()
        }
    }
    
    func getUserInfoFromFirebase() {
        let db = Firestore.firestore()
        
        if let user = Auth.auth().currentUser {
            let uid = user.uid
            
            db.collection("User").document(uid).getDocument { [weak self] (document, error) in
                guard let strongSelf = self else { return }
                if let document = document, document.exists {
                    User.current.login(id: document.documentID, name: document.get("name") as? String, address: document.get("address") as? String, email: document.get("email") as? String ?? user.email, phone: document.get("phone") as? String, isManager: document.get("is_manager") as? Bool ?? false, photo: document.get("photo") as? String)
                    LocalDatabase.shared.removeObjects(ofType: User.self)
                    LocalDatabase.shared.set(User.current)
                    strongSelf.delegate?.signInSuccess()
                } else {
                    print("No document")
                }
            }
        }
    }
}
