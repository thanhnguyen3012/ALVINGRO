//
//  LikedProduct.swift
//  alvingro
//
//  Created by Thành Nguyên on 01/06/2021.
//

import Foundation
import RealmSwift

/// Used for storage Liked Product of User.current in local - synchronize to Firebase when logout
class LikedProduct: Object {
    @objc dynamic var idProduct: String?
    @objc dynamic var idUser: String?
    
    convenience init(idProduct: String, idUser: String) {
        self.init()
        self.idProduct = idProduct
        self.idUser = idUser
    }
    
    override class func primaryKey() -> String {
        return "idProduct"
    }
}
