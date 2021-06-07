//
//  User.swift
//  alvingro
//
//  Created by Thành Nguyên on 31/05/2021.
//

import Foundation

class User {
    static let current = User()
    var id: String = ""
    var name: String = ""
    var address: String?
    var email: String?
    var phone: String?
    var likedList = [String]()
    var isManager = false
    
    private init() {}
}
