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
}
