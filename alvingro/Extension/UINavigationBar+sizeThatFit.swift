//
//  UINavigationBar+sizeThatFit.swift
//  alvingro
//
//  Created by Thành Nguyên on 20/05/2021.
//

import UIKit

extension UINavigationBar {
    open override func sizeThatFits(_ size: CGSize) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: size.height)
    }
}
