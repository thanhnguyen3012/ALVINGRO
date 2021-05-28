//
//  Product.swift
//  alvingro
//
//  Created by Thành Nguyên on 20/05/2021.
//

import Foundation
import Firebase

public class Product: NSObject, NSCoding, Codable{
    
    var id: String?
    var photos: [String]?
    var name: String?
    var amount: Int?
    var price: Float?
    var unit: String?
    var details: String?
    var nutrition: [String]?
    var rate: Float?
    var categories: [String]?
    var brand: String?
    
    init(id: String?, photos: [String]?, name: String?, amount: Int?, price: Float?, unit: String?, details: String?, nutrition: [String]?, rate: Float?, categories: [String]?, brand: String?) {
        self.id = id
        self.photos = photos
        self.name = name
        self.amount = amount
        self.price = price
        self.unit = unit
        self.details = details
        self.nutrition = nutrition
        self.rate = rate
        self.categories = categories
        self.brand = brand
    }
    
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
    
    enum Key: String {
        case id = "id"
        case photos = "photos"
        case name = "name"
        case amount = "amount"
        case price = "price"
        case unit = "unit"
        case details = "details"
        case nutrition = "nutrition"
        case rate = "rate"
        case categories = "categories"
        case brand = "brand"
    }
    
    public func encode(with coder: NSCoder) {
        coder.encode(id, forKey: Key.id.rawValue)
        coder.encode(photos, forKey: Key.photos.rawValue)
        coder.encode(name, forKey: Key.name.rawValue)
        coder.encode(amount, forKey: Key.amount.rawValue)
        coder.encode(price, forKey: Key.price.rawValue)
        coder.encode(unit, forKey: Key.unit.rawValue)
        coder.encode(details, forKey: Key.details.rawValue)
        coder.encode(nutrition, forKey: Key.nutrition.rawValue)
        coder.encode(rate, forKey: Key.rate.rawValue)
        coder.encode(categories, forKey: Key.categories.rawValue)
        coder.encode(brand, forKey: Key.brand.rawValue)
    }
    
    public required convenience init?(coder: NSCoder) {
        let mID = coder.decodeObject(forKey: Key.id.rawValue) as! String
        let mPhotos = coder.decodeObject(forKey: Key.photos.rawValue) as! [String]
        let mName = coder.decodeObject(forKey: Key.name.rawValue) as! String
        let mAmount = coder.decodeObject(forKey: Key.amount.rawValue) as! Int
        let mPrice = coder.decodeObject(forKey: Key.price.rawValue) as! Float
        let mUnit = coder.decodeObject(forKey: Key.unit.rawValue) as! String
        let mDetails = coder.decodeObject(forKey: Key.details.rawValue) as! String
        let mNutrition = coder.decodeObject(forKey: Key.nutrition.rawValue) as! [String]
        let mRate = coder.decodeObject(forKey: Key.rate.rawValue) as! Float
        let mCategories = coder.decodeObject(forKey: Key.categories.rawValue) as! [String]
        let mBrand = coder.decodeObject(forKey: Key.brand.rawValue) as! String
        
        self.init(id: mID, photos: mPhotos, name: mName, amount: mAmount, price: mPrice, unit: mUnit, details: mDetails, nutrition: mNutrition, rate: mRate, categories: mCategories, brand: mBrand)
    }
    
    init(snapshot: QueryDocumentSnapshot) {
        self.id = snapshot.documentID
        self.photos = snapshot.get("photos") as? [String]
        self.name = snapshot.get("name") as? String
        self.amount = snapshot.get("amount") as? Int
        self.price = snapshot.get("price") as? Float
        self.unit = snapshot.get("unit") as? String
        self.details = snapshot.get("details") as? String
        self.nutrition = snapshot.get("nutrition") as? [String]
        self.rate = snapshot.get("rate") as? Float
        self.categories = snapshot.get("categories") as? [String]
        self.brand = snapshot.get("brand") as? String
    }
}
