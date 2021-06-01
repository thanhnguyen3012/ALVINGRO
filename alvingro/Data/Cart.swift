//
//  Cart .swift
//  alvingro
//
//  Created by Thành Nguyên on 01/06/2021.
//

import Foundation
import Firebase
import RealmSwift

/// Every Cart instance storages info of 1 product in basket store of an User (with idUser)
class Card: Object, Codable {
    @objc dynamic var idProduct: String?
    @objc dynamic var idUser: String?
    @objc dynamic var amount: Int = 0
    
    override init() {}
    
    convenience init(idProduct: String, idUser: String, amount: Int) {
        self.init()
        self.idProduct = idProduct
        self.idUser = idUser
        self.amount = amount
    }
    
    init(snapshot: QueryDocumentSnapshot) {
        self.idProduct = snapshot.get("id_product") as? String
        self.idUser = snapshot.get("id_user") as? String
        self.amount = snapshot.get("amount") as? Int ?? 0
    }
}
