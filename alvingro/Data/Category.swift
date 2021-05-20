//
//  Category.swift
//  alvingro
//
//  Created by Thành Nguyên on 20/05/2021.
//

import Foundation

class Category: Codable {
    var id: String?
    var name: String?
    var photo: String?
    
    init(id: String?, name: String?, photo: String?) {
        self.id = id
        self.name = name
        self.photo = photo
    }
}
