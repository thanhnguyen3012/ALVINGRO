//
//  DetailsViewModel.swift
//  alvingro
//
//  Created by Thành Nguyên on 28/05/2021.
//

import Foundation

protocol DetailsViewModelEvents: AnyObject {
    func changeAmountFail(message: String, disableIncreaseButton: Bool, disableDecreaseButton: Bool)
    func changeAmount(amount: Int, disableIncreaseButton: Bool, disableDecreaseButton: Bool)
    func showNotification(title: String, message: String)
}

class DetailsViewModel {
    
    weak var delegate: DetailsViewModelEvents?
    var product = Product()
    var amount = 1
    
    init(delegate: DetailsViewModelEvents) {
        self.delegate = delegate
    }
    
    func getNutritionString() -> String {
        let nutritions = product.nutrition
        if nutritions.count == 0 {
            return "No nutritional information is available for this product."
        }
        var result = ""
        for nutri in nutritions {
            result += nutri + "\n"
        }
        return result
    }
    
    func validAmount() {
        delegate?.changeAmount(amount: amount, disableIncreaseButton: amount >= product.amount, disableDecreaseButton: amount <= 1)
    }

    func increaseAmount() {
        amount += 1
        validAmount()
    }

    func decreaseAmount() {
        amount -= 1
        validAmount()
    }

    //For enter from keyboard mode
    func changeAmount(newValue: Int) {
        if newValue > 0 && newValue <= product.amount {
            amount = newValue
            validAmount()
            return
        }
        if newValue > product.amount {
            amount = product.amount
            delegate?.changeAmountFail(message: "The number of products left is not enough", disableIncreaseButton: true, disableDecreaseButton: amount <= 1)
            return
        }
        delegate?.changeAmountFail(message: "Invalid input.", disableIncreaseButton: amount >= product.amount, disableDecreaseButton: amount <= 1)
    }
    
    func getStateOfLoveButton() -> Bool {
        return LocalDatabase.shared.isExist(key: "idProduct", value: product.id ?? "", ofType: LikedProduct.self)
    }

    // isSelected talk you that wheather LikeButton is being selected or not
    func addToLikeList(isSelected: Bool) {
        let likedProduct = LikedProduct(idProduct: product.id ?? "", idUser: User.current.id)
        print("Liked: \(likedProduct)")
        if isSelected {
            // Add an LikedProduct into realm db
            LocalDatabase.shared.set(likedProduct)
        } else {
            // Remove likedProduct out off realm
            LocalDatabase.shared.removeAnObject(ofType: LikedProduct.self, key: "idProduct", value: product.id ?? "")
        }
    }
    
    func addToCart() {
        LocalDatabase.shared.updateAmountCart(idProduct: product.id ?? "", amountOffset: amount)
        delegate?.showNotification(title: "Success", message: "Add to cart successfully.")
    }
}
