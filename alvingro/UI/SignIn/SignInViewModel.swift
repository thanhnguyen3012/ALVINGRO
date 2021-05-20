//
//  SignInViewModel.swift
//  alvingro
//
//  Created by Thành Nguyên on 17/05/2021.
//

import Foundation
import Firebase

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
                print(authResult)
                strongSelf.delegate?.signInSuccess()
            }
      }
    }
}
