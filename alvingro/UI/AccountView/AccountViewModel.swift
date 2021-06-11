//
//  AccountViewModel.swift
//  alvingro
//
//  Created by Thành Nguyên on 07/06/2021.
//

import UIKit
import Firebase

protocol AccountViewModelEvents: AnyObject {
    func noLoggedIn()
    func updateUserInfo(image: String?, name: String, email: String)
    func showAlert(title: String, message: String)
    func showLoginView()
}

class AccountViewModel {
    weak var delegate: AccountViewModelEvents?
    let optionList = ["Orders", "My Details", "Delivery Address", "Promo card", "Notification"]
    
    init(delegate: AccountViewModelEvents) {
        self.delegate = delegate
        checkCurrentAccount()
    }
    
    func getTitleForTableViewCellAt(index: Int) -> String {
        return optionList[index % optionList.count]
    }
    
    func getImageForTableViewAt(index: Int) -> UIImage {
        switch (index % optionList.count) {
        case 0:
            return UIImage(named: "Orders") ?? UIImage()
        case 1:
            return UIImage(named: "MyDetails") ?? UIImage()
        case 2:
            return UIImage(named: "Delivery") ?? UIImage()
        case 3:
            return UIImage(named: "Promo") ?? UIImage()
        case 4:
            return UIImage(named: "Bell") ?? UIImage()
        default:
            return UIImage(named: "PlaceholderImage") ?? UIImage()
        }
    }
    
    func checkCurrentAccount() {
        if (Auth.auth().currentUser != nil) && (LocalDatabase.shared.isExist(key: "id", value: Auth.auth().currentUser?.uid ?? "", ofType: User.self)) {
            delegate?.updateUserInfo(image: User.current.photo, name: User.current.name ?? "Unknown", email: User.current.email ?? "")
        } else {
            delegate?.noLoggedIn()
        }
    }
    
    func loggout() {
        if Auth.auth().currentUser != nil {
            do {
                try Auth.auth().signOut()
                //Remove local User
                LocalDatabase.shared.removeObjects(ofType: User.self)
                checkCurrentAccount()
            } catch {
                delegate?.showAlert(title: "Logout id unsuccessful", message: "")
            }
        } else {
            delegate?.showLoginView()
        }
    }
}
