//
//  Category.swift
//  alvingro
//
//  Created by Thành Nguyên on 20/05/2021.
//

import Foundation
import Firebase
import RealmSwift

class Category: Object, Codable {
    @objc dynamic var id: String?
    @objc dynamic var name: String?
    @objc dynamic var photo: String?
    
    override init() {}
    
    convenience init(id: String?, name: String?, photo: String?) {
        self.init()
        self.id = id
        self.name = name
        self.photo = photo
    }
    
    init(snapshot: QueryDocumentSnapshot) {
        self.id = snapshot.documentID
        self.name = snapshot.get("name") as? String
        self.photo = snapshot.get("photo") as? String
    }
}
