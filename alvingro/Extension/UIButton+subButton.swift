//
//  UIButton+subButton.swift
//  alvingro
//
//  Created by Thành Nguyên on 07/06/2021.
//

import UIKit

extension UIButton {
    func subButton() {
        self.layer.cornerRadius = 20
        self.clipsToBounds = true
        self.backgroundColor = UIColor(named: "BackGround-gray")
        self.setTitleColor(UIColor(named: "MainGreen"), for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        self.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 50, height: 67)
    }
}
