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
    
    private init() {}
}

struct Defaults {
    static let (nameKey, addressKey) = ("name", "address")
    static let userSessionKey = "com.save.usersession"
    private static let userDefault = UserDefaults.standard
    
    /**
       Nó được sử dụng để lấy ra và gán giá trị người dùng vào UserDefaults
     */
    struct UserDetails {
        let name: String
        let address: String
        
        init(_ json: [String: String]) {
            self.name = json[nameKey] ?? ""
            self.address = json[addressKey] ?? ""
        }
    }
    
    /**
     - Lưu chi tiết người dùng
     - Inputs - name `String` & address `String`
     */
    static func save(_ name: String, address: String){
        userDefault.set([nameKey: name, addressKey: address],
                        forKey: userSessionKey)
    }
    
    /**
     - Tìm nạp các giá trị thông qua Model `UserDetails`
     - Output - `UserDetails` model
     */
    static func getNameAndAddress()-> UserDetails {
        return UserDetails((userDefault.value(forKey: userSessionKey) as? [String: String]) ?? [:])
    }
    
    /**
        - Xoá chi tiết người dùng trong UserDefault qua key "com.save.usersession"
     */
    static func clearUserData(){
        userDefault.removeObject(forKey: userSessionKey)
    }
}
