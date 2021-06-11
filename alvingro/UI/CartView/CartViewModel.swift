//
//  CartViewModel.swift
//  alvingro
//
//  Created by Thành Nguyên on 28/05/2021.
//

import Foundation
import Firebase
import FirebaseFirestore
import RealmSwift

protocol CartViewModelEvents: AnyObject {
    func updateCart(totalPrice: Float)
    func updateCartAt(index: Int)
    func loginRequire()
    func checkOutUnsuccess(reason: String)
    func showCheckOutView(order: Order)
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
            if cart.amount > product.amount {
                LocalDatabase.shared.updateAmountCart(idProduct: cart.idProduct ?? "", amountOffset: product.amount - cart.amount)
            }
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
            LocalDatabase.shared.updateAmountCart(idProduct: cartsList[index].idProduct ?? "", amountOffset: offsetValue)
            delegate?.updateCartAt(index: index)
        }
    }
    
    func deleteCart(index: Int) {
        LocalDatabase.shared.removeAnObject(ofType: Cart.self, key: "idProduct", value: cartsList[index].idProduct ?? "")
        getCartFromDevice()
    }
    
    func checkout() {
        if Auth.auth().currentUser == nil {
            delegate?.loginRequire()
        } else {
            // 1 - Sync all product between Firebase and local database
            LocalDatabase.shared.syncWithFirebase(ofType: Product.self, collection: "Product")
            
            // 2 - Create an order
            let order = Order(id: "temp", idUser: User.current.id, product: List<String>(), amount: List<Int>(), address: User.current.address ?? "", paymentMethod: nil, voucher: nil, totalCost: reloadTotalPrice(), finalCost: reloadTotalPrice(), state: OrderState.offline)
            
            
            // 3 - Check number of product remain in stock and add it to the order if possible
            for i in 0..<cartsList.count {
                guard let item = LocalDatabase.shared.getAnObject(key: "id", value: cartsList[i].idProduct ?? "", ofType: Product.self) else {
                    delegate?.checkOutUnsuccess(reason: "Product \(productsList[i].name ?? "") is no longer available.")
                    LocalDatabase.shared.removeAnObject(ofType: Order.self, key: "id", value: order.id ?? "")
                    return
                }
                if cartsList[i].amount <= item.amount {
                    order.product.append(cartsList[i].idProduct ?? "")
                    order.amount.append(cartsList[i].amount)
                } else {
                    delegate?.checkOutUnsuccess(reason: "The remaining quantity of product \(productsList[i].name ?? "") is not enough.")
                    LocalDatabase.shared.removeAnObject(ofType: Order.self, key: "id", value: order.id ?? "")
                    return
                }
            }
            
            delegate?.showCheckOutView(order: order)
            return
        }
    }
}
