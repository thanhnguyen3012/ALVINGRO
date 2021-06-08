//
//  QuerySnapshot+toObject.swift
//  alvingro
//
//  Created by Thành Nguyên on 08/06/2021.
//

import Foundation
import FirebaseFirestore

extension QuerySnapshot {
    func toObject<T: Decodable>() throws -> [T] {
        let objects: [T] = try documents.map({ try $0.toObject() })
        return objects
    }
}
