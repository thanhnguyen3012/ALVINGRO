//
//  QueryDocumentSnapshot+toObject.swift
//  alvingro
//
//  Created by Thành Nguyên on 08/06/2021.
//

import Foundation
import FirebaseFirestore

extension QueryDocumentSnapshot {
    func toObject<T: Decodable>() throws -> T {
        let jsonData = try JSONSerialization.data(withJSONObject: data(), options: [])
        let object = try JSONDecoder().decode(T.self, from: jsonData)
        
        return object
    }
}

