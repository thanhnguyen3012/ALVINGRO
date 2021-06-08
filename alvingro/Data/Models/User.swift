//
//  User.swift
//  alvingro
//
//  Created by Thành Nguyên on 31/05/2021.
//

import Foundation
import Firebase
import RealmSwift

class User: Object, Codable {
    static var current = User()
    @objc dynamic var id: String = ""
    @objc dynamic var name: String?
    @objc dynamic var address: String?
    @objc dynamic var email: String?
    @objc dynamic var phone: String?
    var likedList = List<String>()
    @objc dynamic var isManager = false
    @objc dynamic var photo: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case address
        case email
        case phone
        case likedList = "liked_list"
        case isManager = "is_manager"
        case photo
    }

    
    func logout() {
        id = ""
        name = nil
        address = nil
        email = nil
        phone = nil
        isManager = false
        photo = nil
    }
    
    func login(id: String, name: String?, address: String?, email: String?, phone: String?, isManager: Bool, photo: String?) {
        self.id = id
        self.name = name
        self.address = address
        self.email = email
        self.phone = phone
        self.isManager = isManager
        self.photo = photo
    }
    
    func updateName(newName: String) {
        name = newName
    }
    
    func updateAddress(newAddress: String) {
        address = newAddress
    }
    
    func updateEmail(newEmail: String) {
        email = newEmail
    }
    
    func updatePhone(newPhone: String) {
        phone = newPhone
    }
    
    func updatePhoto(newUrl: String) {
        photo = newUrl
    }
    
    private override init() {}
    
    func getFromLocal() {
        if Auth.auth().currentUser != nil {
            if LocalDatabase.shared.getAll(targetType: User.self).count > 0 {
                User.current = LocalDatabase.shared.getAll(targetType: User.self)[0]
            }
        } else {
            LocalDatabase.shared.removeObjects(ofType: User.self)
        }
    }
}
