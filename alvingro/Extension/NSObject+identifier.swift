//
//  NSObject+identifier.swift
//  alvingro
//
//  Created by Thành Nguyên on 17/05/2021.
//

import UIKit

extension NSObject {
    
    static var identifier: String {
        return String(describing: self)
    }
    
    static var nib : UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
}
