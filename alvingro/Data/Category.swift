//
//  Category.swift
//  alvingro
//
//  Created by Thành Nguyên on 20/05/2021.
//

import Foundation
import Firebase

class Category: Codable {
    var id: String?
    var name: String?
    var photo: String?
    
    init(id: String?, name: String?, photo: String?) {
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