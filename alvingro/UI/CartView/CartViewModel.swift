//
//  CartViewModel.swift
//  alvingro
//
//  Created by Thành Nguyên on 28/05/2021.
//

import Foundation

protocol CartViewModelEvents: AnyObject {
    func updateCart(totalPrice: Float)
    func updateCartAt(index: Int)
}

class CartViewModel {
    weak var delegate: CartViewModelEvents?
    
    var cartsList = [Cart]()
    var productsList = [Product]()
    
    init(delegate: CartViewModelEvents) {
        self.delegate = delegate
        getCartFromDevice()
    }
    
    func getCartFromDevice() {
        cartsList.removeAll()
        productsList.removeAll()
        cartsList = LocalDatabase.shared.getAll(targetType: Cart.self)
        for cart in cartsList {
            guard let product = LocalDatabase.shared.getAnObject(key: "id", value: cart.idProduct ?? "", ofType: Product.self) else { continue }
            productsList.append(product)
        }
        delegate?.updateCart(totalPrice: reloadTotalPrice())
    }
    
    func reloadTotalPrice() -> Float {
        var result: Float = 0
        for i in 0..<cartsList.count {
            result += Float(cartsList[i].amount) * productsList[i].price
        }
        return result
    }
    
    func changeAmount(at index: Int, offsetValue: Int) {
        // check maximun amount of this proct to decion whether amount in cart can be changed
        if (cartsList[index].amount + offsetValue <= productsList[index].amount) && (cartsList[index].amount + offsetValue > 0) {
            LocalDatabase.shared.updateAmountCart(idProduct: cartsList[index].idProduct ?? "", newAmount: cartsList[index].amount + offsetValue)
            delegate?.updateCartAt(index: index)
        }
    }
    
    func deleteCart(index: Int) {
        LocalDatabase.shared.removeAnObject(ofType: Cart.self, key: "idProduct", value: cartsList[index].idProduct ?? "")
        getCartFromDevice()
    }
}
