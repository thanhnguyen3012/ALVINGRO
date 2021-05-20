//
//  ResponseError.swift
//  alvingro
//
//  Created by Thành Nguyên on 20/05/2021.
//

import Foundation

class ResponseError: Codable, Error {
    var key: String?
    var errors: [String]?
}
