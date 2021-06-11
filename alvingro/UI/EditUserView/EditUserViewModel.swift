//
//  EditUserViewModel.swift
//  alvingro
//
//  Created by Thành Nguyên on 07/06/2021.
//

import UIKit
import Firebase

protocol EditUserViewModelEvents: AnyObject {
    func userProfileSaved()
}

class EditUserViewModel {
    weak var delegate: EditUserViewModelEvents?
    
    init(delegate: EditUserViewModelEvents) {
        self.delegate = delegate
//        getUserFromDevice()
    }
    
    func getUserFromDevice() {
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
        return User.current.address ?? ""
    }
    
    func saveChange(name: String?, email: String?, phone: String?, address: String?) {
        User.current.updateName(newName: name)
        User.current.updateEmail(newEmail: email)
        User.current.updatePhone(newPhone: phone)
        User.current.updateAddress(newAddress: address)
        delegate?.userProfileSaved()
    }
    
}
