//
//  Product.swift
//  alvingro
//
//  Created by Thành Nguyên on 20/05/2021.
//

import Foundation
import Firebase
import RealmSwift

class Product: Object, Codable {
    @objc dynamic var id: String?
    var photos = List<String>()
    @objc dynamic var name: String?
    @objc dynamic var amount: Int = 0
    @objc dynamic var price: Float = 0
    @objc dynamic var unit: String?
    @objc dynamic var details: String?
    var nutrition = List<String>()
    @objc dynamic var rate: Float = 0
    var categories = List<String>()
    @objc dynamic var brand: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case photos
        case name
        case amount
        case price
        case unit
        case details
        case nutrition
        case rate
        case categories
        case brand
    }
    
    override init() {}
    
    convenience init(id: String?, photos: [String]?, name: String?, amount: Int, price: Float, unit: String?, details: String?, nutrition: [String]?, rate: Float, categories: [String]?, brand: String?) {
        self.init()
        self.id = id
        self.photos.append(objectsIn: photos ?? [])
        self.name = name
        self.amount = amount
        self.price = price
        self.unit = unit
        self.details = details
        self.nutrition.append(objectsIn: nutrition ?? [])
        self.rate = rate
        self.categories.append(objectsIn: categories ?? [])
        self.brand = brand
    }
    
    init(snapshot: QueryDocumentSnapshot) {
        self.id = snapshot.documentID
        self.photos.append(objectsIn: snapshot.get("photos") as? List<String> ?? List<String>())
        self.name = snapshot.get("name") as? String
        self.amount = snapshot.get("amount") as? Int ?? 0
        self.price = snapshot.get("price") as? Float ?? 0
        self.unit = snapshot.get("unit") as? String
        self.details = snapshot.get("details") as? String
        self.nutrition.append(objectsIn: snapshot.get("nutrition") as? List<String> ?? List<String>())
        self.rate = snapshot.get("rate") as? Float ?? 0
        self.categories.append(objectsIn: snapshot.get("categories") as? List<String> ?? List<String>())
        self.brand = snapshot.get("brand") as? String
    }
    
//    override static func primaryKey() -> String? {
//       return "id"
//   }
}
