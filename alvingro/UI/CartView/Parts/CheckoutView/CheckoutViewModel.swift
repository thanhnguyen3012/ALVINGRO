//
//  CheckoutViewModel.swift
//  alvingro
//
//  Created by Thành Nguyên on 10/06/2021.
//

import Foundation
import FirebaseFirestore

protocol CheckoutViewModelEvents: AnyObject {
    func updateTotalPrice(price: Float)
    func updatePromo(discountPercent: Float)
    func checkoutSuccess(order: Order)
    func checkoutFail(reason: String)
}

class CheckoutViewModel {

    weak var delegate: CheckoutViewModelEvents?
    
    var order = Order()
    
    init(delegate: CheckoutViewModelEvents) {
        self.delegate = delegate
    }
    
    func setData(order: Order) {
        self.order = order
    }
    
    func checkPromo(code: String) {
        guard let voucher = LocalDatabase.shared.getAnObject(key: "id", value: code, ofType: Voucher.self) else {
            // code isn't available
            delegate?.updatePromo(discountPercent: 0)
            return
        }
    
        // code is available
        addDiscountToPrice(discountPercent: voucher.discount)
        delegate?.updatePromo(discountPercent: voucher.discount)
        
    }
    
    func addDiscountToPrice(discountPercent: Float) {
        let newPrice = order.totalCost - (order.totalCost * discountPercent)
        LocalDatabase.shared.updateFinalPriceOfOrder(id: order.id ?? "", newPrice: newPrice)
        delegate?.updateTotalPrice(price: newPrice)
    }
    
    func checkout() {
        
        // 1 - Decrease amout of product in stock (Firebase and Realm)
        for i in 0..<order.product.count {
            LocalDatabase.shared.updateAmountProduct(id: order.product[i], offset: -order.amount[i])
        }
        
        // 2 - Clear cart (Firebase and Realm)
        LocalDatabase.shared.removeObjects(ofType: Cart.self)
        
        // 3 - Storage to local database
        order.id = ""
        LocalDatabase.shared.set(order)
        
        // 4 - Upload Order to Firebase
        let db = Firestore.firestore()
        do {
            let encoder = JSONEncoder()
            let jsonData = try encoder.encode(order)
            guard let json = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String : Any] else { return }
            db.collection("Order").document().setData(json, completion: { [weak self] (error) in
                guard let self = self else { return }
                if error != nil {
                    LocalDatabase.shared.updateStateOfOrder(id: self.order.id ?? "", state: OrderState.wait.rawValue)
                }
            })
        } catch let error {
            print("Log in error: \(error)")
            delegate?.checkoutFail(reason: error.localizedDescription)
        }
        
        delegate?.checkoutSuccess(order: order)
    }
}
