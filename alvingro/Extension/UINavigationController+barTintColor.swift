//
//  UINavigationController+barTintColor.swift
//  alvingro
//
//  Created by Thành Nguyên on 11/06/2021.
//

import UIKit

@IBDesignable extension UINavigationController {
    @IBInspectable var barTintColor: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            navigationBar.barTintColor = uiColor
        }
        get {
            guard let color = navigationBar.barTintColor else { return nil }
            return color
        }
    }
}
