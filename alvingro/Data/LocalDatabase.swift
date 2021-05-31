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
}
