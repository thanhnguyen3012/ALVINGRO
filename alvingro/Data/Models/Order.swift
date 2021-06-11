//
//  Order.swift
//  alvingro
//
//  Created by Thành Nguyên on 08/06/2021.
//

import Foundation
import RealmSwift
import Firebase
import FirebaseFirestore

enum OrderState: String {
    case offline = "Your order has not been sent"
    case wait = "Wait for confirmation"
    case accept = "Accepted by store"
    case delivery = "Shipper is on the way to you"
    case finish = "Successful delivery"
    case fail = "Order is canceled"
}

class Order: Object, Codable {
    @objc dynamic var id: String?
    @objc dynamic var idUser: String?
    var product = List<String>()
    var amount = List<Int>()
    @objc dynamic var address: String?
    @objc dynamic var paymentMethod = "Cash"
    @objc dynamic var voucher: String?
    @objc dynamic var totalCost: Float = 0
    @objc dynamic var finalCost: Float = 0
    @objc dynamic var state: OrderState.RawValue = OrderState.wait.rawValue
    
    enum CodingKeys: String, CodingKey {
        case id
        case idUser = "id_user"
        case product
        case amount
        case address
        case paymentMethod = "payment_method"
        case voucher
        case totalCost = "total_cost"
        case finalCost = "final_cost"
        case state
    }
    
    override init() {}
    
    convenience init(id: String, idUser: String, product: List<String>, amount: List<Int>, address: String, paymentMethod: String?, voucher: String?, totalCost: Float, finalCost: Float, state: OrderState) {
        self.init()
        self.id = id
        self.idUser = idUser
        self.product = product
        self.amount = amount
        self.address = address
        self.paymentMethod = paymentMethod ?? "Cash"
        self.voucher = voucher
        self.totalCost = totalCost
        self.finalCost = finalCost
        self.state = state.rawValue
    }
    
    init(snapshot: QueryDocumentSnapshot) {
        self.id = snapshot.get("id") as? String
        self.idUser = snapshot.get("id_user") as? String
        self.product = snapshot.get("product") as? List<String> ?? List<String>()
        self.amount = snapshot.get("amount") as? List<Int> ?? List<Int>()
        self.address = snapshot.get("address") as? String
        self.paymentMethod = snapshot.get("payment_method") as? String ?? "Cash"
        self.voucher = snapshot.get("voucher") as? String
        self.totalCost = snapshot.get("total_cost") as? Float ?? 0
        self.finalCost = snapshot.get("final_cost") as? Float ?? 0
        self.state = snapshot.get("state") as? String ?? OrderState.wait.rawValue
    }
}
