//
//  LocalDatabase.swift
//  alvingro
//
//  Created by Thành Nguyên on 31/05/2021.
//

import Foundation
import RealmSwift

class LocalDatabase {
    static let shared = LocalDatabase()
    
    private let db = try! Realm()
    
    private init() {}
    
    func getAll<T: Object>(targetType: T.Type) -> [T] {
        try! db.write {
            return db.objects(T.self).toArray(ofType: T.self)
        }
    }
    
    func getAnObject<T: Object>(key: String, value: String, ofType: T.Type) -> T? {
        try! db.write {
            return db.objects(T.self).filter("\(key) = %@", value).first
        }
    }
    
    func getObjects<T: Object>(key: String, value: String, ofType: T.Type) -> [T] {
        try! db.write {
            return db.objects(T.self).filter("\(key) = %@", value).toArray(ofType: T.self)
        }
    }
    
    func set<T: Object>(_ item: T) {
        try! db.write {
            db.add(item)
        }
    }
    
    func updateAmountCart(idProduct: String, amountOffset: Int) {
        // If Cart isexisting, change amount
        if let cart = self.getAnObject(key: "idProduct", value: idProduct, ofType: Cart.self) {
            try! db.write {
                cart.amount = cart.amount + amountOffset
            }
        } else { // If cart is not existing, create new Cart
            self.set(Cart(idProduct: idProduct, idUser: User.current.id, amount: amountOffset))
        }
    }
    
    func removeAnObject<T: Object>(ofType: T.Type, key: String, value: String) {
        if let object = db.objects(T.self).filter("\(key) = %@", value).first {
            try! db.write {
                db.delete(object)
            }
        }
    }
    
    func removeObjects<T: Object>(ofType: T.Type) {
        try! db.write {
            db.delete(db.objects(ofType.self))
        }
    }
    
    func isExist<T: Object>(key: String, value: String, ofType: T.Type) -> Bool {
        if let _ = db.objects(T.self).filter("\(key) = %@", value).first {
            return true
        }
        return false
    }
}
