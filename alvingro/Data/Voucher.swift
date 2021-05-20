//
//  Voucher.swift
//  alvingro
//
//  Created by Thành Nguyên on 20/05/2021.
//

import Foundation

class Voucher: Codable{
    var id: String?
    var discount: Float?
    var allow: [String]?
    var startDate: Date?
    var exp: Date?
    var amount: Int?
    var photo: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case discount
        case allow
        case startDate = "start_date"
        case exp
        case amount
        case photo
    }
    
    init(id: String?, discount: Float?, allow: [String]?, startDate: Date, exp: Date?, amount: Int?, photo: String?) {
        self.id = id
        self.discount = discount
        self.allow = allow
        self.startDate = startDate
        self.exp = exp
        self.amount = amount
        self.photo = photo
    }
}
