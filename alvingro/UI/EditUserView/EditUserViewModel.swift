//
//  EditUserViewModel.swift
//  alvingro
//
//  Created by Thành Nguyên on 07/06/2021.
//

import UIKit
import Firebase

protocol EditUserViewModelEvents: AnyObject {
    
}

class EditUserViewModel {
    weak var delegate: EditUserViewModelEvents?
    
    init(delegate: EditUserViewModelEvents) {
        self.delegate = delegate
        getUserFromFirebase()
    }
    
    func getUserFromFirebase() {
        if let user = Auth.auth().currentUser {
            User.current.id = user.uid
        }
    }
    
    func getCurrentImage() -> UIImage? {
        var photo = UIImage(named: "PlaceholderImage")
        UIImageView().getImageFromURL(url: User.current.photo ?? "", completionHandler: { img in
            if img != nil {
                photo = img
            }
        })
        return photo
    }
    
    func getCurrentName() -> String {
        return User.current.name ?? ""
    }
    
    func getCurrentEmail() -> String {
        return User.current.email ?? ""
    }
    
    func getCurrentPhone() -> String {
        return User.current.phone ?? ""
    }
    
    func getCurrentAddress() -> String {
        return ""
    }
    
    func saveChange(name: String, email: String, phone: String, address: String) {
        
    }
    
}
