//
//  LocalDatabase.swift
//  alvingro
//
//  Created by Thành Nguyên on 31/05/2021.
//

import Foundation
import RealmSwift
import Firebase
import FirebaseFirestore

class LocalDatabase {
    static let shared = LocalDatabase()
    
    private let db = try! Realm()
    
    private init() {
//        let fb = Firestore.firestore()
//
//        //Get products from firebase
//        fb.collection("Product").getDocuments() { [weak self] (querySnapshot, err) in
//            guard let self = self else { return }
//            if let err = err {
//                print("Error getting documents: \(err)")
//            } else {
//                if let list:[Product] = try? querySnapshot?.toObject() {
//                    self.removeObjects(ofType: Product.self)
//                    self.set(list: list)
//                }
//            }
//        }
//
//        //Get orders from firebase
//        fb.collection("Order").getDocuments() { [weak self] (querySnapshot, err) in
//            guard let self = self else { return }
//            if let err = err {
//                print("Error getting documents: \(err)")
//            } else {
//                if let list:[Order] = try? querySnapshot?.toObject() {
//                    self.removeObjects(ofType: Order.self)
//                    self.set(list: list)
//                }
//            }
//        }
//
//        //Get vouchers from firebase
//        fb.collection("Voucher").getDocuments() { [weak self] (querySnapshot, err) in
//            guard let self = self else { return }
//            if let err = err {
//                print("Error getting documents: \(err)")
//            } else {
//                if let list:[Voucher] = try? querySnapshot?.toObject() {
//                    self.removeObjects(ofType: Voucher.self)
//                    self.set(list: list)
//                }
//            }
//        }
//
//
//        //Get categories from firebase
//        fb.collection("Category").getDocuments() { [weak self] (querySnapshot, err) in
//            guard let self = self else { return }
//            if let err = err {
//                print("Error getting documents: \(err)")
//            } else {
//                if let list:[Category] = try? querySnapshot?.toObject() {
//                    self.removeObjects(ofType: Category.self)
//                    self.set(list: list)
//                }
//            }
//        }
//
//        //Get brands from firebase
//        fb.collection("Brand").getDocuments() { [weak self] (querySnapshot, err) in
//            guard let self = self else { return }
//            if let err = err {
//                print("Error getting documents: \(err)")
//            } else {
//                if let list:[Brand] = try? querySnapshot?.toObject() {
//                    self.removeObjects(ofType: Brand.self)
//                    self.set(list: list)
//                }
//            }
//        }
    }
    
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
    
    func set<T: Object>(list: [T]) {
        for item in list {
            set(item)
        }
    }
    
    func updateAmountProduct(id: String, offset: Int) {
        if let product = getAnObject(key: "id", value: id, ofType: Product.self) {
            try! db.write {
                product.amount = product.amount + offset
            }
        }
    }
    
    func updateFinalPriceOfOrder(id: String, newPrice: Float) {
        try! db.write {
            if let order = getAnObject(key: "id", value: id, ofType: Order.self) {
                order.finalCost = newPrice
            }
        }
    }
    
    func updateStateOfOrder(id: String, state: OrderState.RawValue) {
        try! db.write {
            if let order = getAnObject(key: "id", value: id, ofType: Order.self) {
                order.state = state
            }
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
    
    
    func updateUserName(newName: String?) {
        if newName == nil { return }
        try! db.write {
            User.current.name = newName
        }
    }
    func updateUserAddress(newAddress: String?) {
        if newAddress == nil { return }
        try! db.write {
            User.current.address = newAddress
        }
    }
    func updateUserEmail(newEmail: String?) {
        if newEmail == nil { return }
        try! db.write {
            User.current.email = newEmail
        }
    }
    func updateUserPhone(newPhone: String?) {
        if newPhone == nil { return }
        try! db.write {
            User.current.phone = newPhone
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
    
    // Use when sync data from Firebase, becase querySnapshot need to be decoded, s otype of it is Codable
    private func removeCollectionInLocal(collection: String) {
        switch collection {
        case "Product":
            removeObjects(ofType: Product.self)
        case "Brand":
            removeObjects(ofType: Brand.self)
        case "Cart":
            removeObjects(ofType: Cart.self)
        case "Category":
            removeObjects(ofType: Category.self)
        case "LikedProduct":
            removeObjects(ofType: LikedProduct.self)
        case "Order":
            removeObjects(ofType: Order.self)
        case "User":
            removeObjects(ofType: User.self)
        case "Voucher":
            removeObjects(ofType: Voucher.self)
        default:
            return
        }
    }
    
    func isExist<T: Object>(key: String, value: String, ofType: T.Type) -> Bool {
        if let _ = db.objects(T.self).filter("\(key) = %@", value).first {
            return true
        }
        return false
    }
    
    func syncWithFirebase<T: Codable>(ofType: T.Type, collection: String) {
        let fb = Firestore.firestore()
        fb.collection(collection).getDocuments() { [weak self] (querySnapshot, err) in
            guard let self = self else { return }
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                if let list:[T] = try? querySnapshot?.toObject() {
                    self.removeCollectionInLocal(collection: collection)
                    self.set(list: list as! [Object])
                }
            }
        }
    }
    
    func upAnObjectToFirebase<T: Encodable>(_ obj: T, collection: String, id: String?) {
        let fb = Firestore.firestore()
        
        do {
            let encoder = JSONEncoder()
            let jsonData = try encoder.encode(obj)
            guard let json = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String : Any] else { return }
            if id == nil {
                fb.collection(collection).document().setData(json)
            } else {
                fb.collection(collection).document(id ?? "").setData(json)
            }
        } catch let error {
            print("Log in error: \(error)")
        }
    }
}
