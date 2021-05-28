//
//  CartViewModel.swift
//  alvingro
//
//  Created by Thành Nguyên on 28/05/2021.
//

import Foundation

protocol CartViewModelEvents: AnyObject {
    func updateCart(totalPrice: Float)
}

class CartViewModel {
    weak var delegate: CartViewModelEvents?
    
    var productsList = [Product]()
    
    init(delegate: CartViewModelEvents) {
        self.delegate = delegate
    }
}
