//
//  Voucher.swift
//  alvingro
//
//  Created by Thành Nguyên on 20/05/2021.
//

import Foundation
import Firebase
import RealmSwift
         
class Voucher: Object, Codable{
    @objc dynamic var id: String?
    @objc dynamic var discount: Float = 0
    var allow = List<String>()
    @objc dynamic var startDate: Date?
    @objc dynamic var exp: Date?
    @objc dynamic var amount: Int = 0
    @objc dynamic var photo: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case discount
        case allow
        case startDate = "start_date"
        case exp
        case amount
        case photo
    }
    
    override init() {}
    
    convenience init(id: String?, discount: Float?, allow: [String]?, startDate: Date, exp: Date?, amount: Int?, photo: String?) {
        self.init()
        self.id = id
        self.discount = discount ?? 0
        self.allow.append(objectsIn: allow ?? [])
        self.startDate = startDate
        self.exp = exp
        self.amount = amount ?? 0
        self.photo = photo
    }
    
    init(snapshot: QueryDocumentSnapshot) {
        self.id = snapshot.documentID
        self.discount = snapshot.get("discount") as? Float ?? 0
        self.allow.append(objectsIn: snapshot.get("allow") as? List<String> ?? List<String>())
        self.startDate = snapshot.get("start_date") as? Date
        self.exp = snapshot.get("exp") as? Date
        self.amount = snapshot.get("amount") as? Int ?? 0
        self.photo = snapshot.get("photo") as? String
    }
}
