//
//  SignUpViewModel.swift
//  alvingro
//
//  Created by Thành Nguyên on 17/05/2021.
//

import Foundation
import Firebase

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
                print(authResult)
                strongSelf.delegate?.signUpSuccess()
            }
        }
    }
}


