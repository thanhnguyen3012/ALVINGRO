//
//  UIButton+mainButton.swift
//  alvingro
//
//  Created by Thành Nguyên on 17/05/2021.
//

import UIKit

extension UIButton {
    func mainButton() {
        self.layer.cornerRadius = 20
        self.clipsToBounds = true
        self.backgroundColor = UIColor(named: "MainGreen")
        self.setTitleColor(.white, for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        self.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 50, height: 67)
    }
}

