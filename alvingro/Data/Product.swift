//
//  Product.swift
//  alvingro
//
//  Created by Thành Nguyên on 20/05/2021.
//

import Foundation

class Product: Codable {
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
}
