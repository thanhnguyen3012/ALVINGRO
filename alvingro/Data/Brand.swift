//
//  Brand.swift
//  alvingro
//
//  Created by Thành Nguyên on 21/05/2021.
//

import Foundation
import Firebase

class Brand: Codable {
    var id: String?
    var name: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
    }
    
    init(id: String, name: String?) {
        self.id = id
        self.name = name
    }
    
    init(snapshot: QueryDocumentSnapshot) {
        self.id = snapshot.documentID
        self.name = snapshot.get("name") as? String
    }
}
