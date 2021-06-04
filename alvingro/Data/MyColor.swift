//
//  MyColor.swift
//  alvingro
//
//  Created by Thành Nguyên on 02/06/2021.
//

import UIKit

// Set color for CategoriesCell conveniently
class MyColor {
    private static let listColor = [  UIColor(red: 248/255, green: 164/255, blue: 76/255, alpha: 1),
                           UIColor(red: 83/255, green: 177/255, blue: 117/255, alpha: 1),
                           UIColor(red: 247/255, green: 165/255, blue: 147/255, alpha: 1),
                           UIColor(red: 211/255, green: 176/255, blue: 224/255, alpha: 1),
                           UIColor(red: 253/255, green: 229/255, blue: 152/255, alpha: 1),
                           UIColor(red: 183/255, green: 223/255, blue: 245/255, alpha: 1),
                           UIColor(red: 131/255, green: 106/255, blue: 246/255, alpha: 1),
                           UIColor(red: 215/255, green: 59/255, blue: 119/255, alpha: 1)]
    
    static func get(_ index: Int) -> UIColor {
        return listColor[index % listColor.count]
    }
}
