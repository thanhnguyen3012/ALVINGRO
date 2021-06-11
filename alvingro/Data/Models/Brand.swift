//
//  Brand.swift
//  alvingro
//
//  Created by Thành Nguyên on 21/05/2021.
//

import Foundation
import Firebase
import RealmSwift

class Brand: Object, Codable {
    @objc dynamic var id: String?
    @objc dynamic var name: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
    }
    
    override init() {}
    
    convenience init(id: String, name: String?) {
        self.init()
        self.id = id
        self.name = name
    }
    
    init(snapshot: QueryDocumentSnapshot) {
        self.id = snapshot.documentID
        self.name = snapshot.get("name") as? String
    }
}
