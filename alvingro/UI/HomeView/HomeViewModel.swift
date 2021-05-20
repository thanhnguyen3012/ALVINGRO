//
//  HomeViewModel.swift
//  alvingro
//
//  Created by Thành Nguyên on 20/05/2021.
//

import UIKit

protocol HomeViewModelEvents: AnyObject {
    func loadedProducts()
}

class HomeViewModel {
    
    weak var delegate: HomeViewModelEvents?
    
//    var highlyRecommendedList = [Product]()
//    var bestSellingList = [Product]()
//    var groceriseList = [Product]()
//    var categoriesList = [Category]()
//    var vouchersList = [Voucher]()
    
    // Mock datas
    var highlyRecommendedList = [
                                    Product(id: "pr1", photos: ["https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQZpkiRbYuYU_NGmV70jMacxknQEKgK24iuMw&usqp=CAU"], name: "Apple", amount: 2, price: 2.34, unit: "1kg", details: "describing about apple", nutrition: ["a", "cbv"], rate: 4.5, categories: ["cat1"], brand: "nobrand"),
                                    Product(id: "pr2", photos: ["https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQZpkiRbYuYU_NGmV70jMacxknQEKgK24iuMw&usqp=CAU"], name: "Stawberry", amount: 3, price: 5.43, unit: "1 kg", details: "no describing", nutrition: ["vitamin Z"], rate: 2.0, categories: ["cat2"], brand: "unknown")]
    var bestSellingList = [
                            Product(id: "pr1", photos: ["https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQZpkiRbYuYU_NGmV70jMacxknQEKgK24iuMw&usqp=CAU"], name: "Apple", amount: 2, price: 2.34, unit: "1kg", details: "describing about apple", nutrition: ["a", "cbv"], rate: 4.5, categories: ["cat1"], brand: "nobrand"),
                            Product(id: "pr2", photos: ["https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQZpkiRbYuYU_NGmV70jMacxknQEKgK24iuMw&usqp=CAU"], name: "Stawberry", amount: 3, price: 5.43, unit: "1 kg", details: "no describing", nutrition: ["vitamin Z"], rate: 2.0, categories: ["cat2"], brand: "unknown")]
    var groceriseList = [
                            Product(id: "pr1", photos: ["https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQZpkiRbYuYU_NGmV70jMacxknQEKgK24iuMw&usqp=CAU"], name: "Apple", amount: 2, price: 2.34, unit: "1kg", details: "describing about apple", nutrition: ["a", "cbv"], rate: 4.5, categories: ["cat1"], brand: "nobrand"),
                            Product(id: "pr2", photos: ["https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQZpkiRbYuYU_NGmV70jMacxknQEKgK24iuMw&usqp=CAU"], name: "Stawberry", amount: 3, price: 5.43, unit: "1 kg", details: "no describing", nutrition: ["vitamin Z"], rate: 2.0, categories: ["cat2"], brand: "unknown")]
    var categoriesList = [Category(id: "cat1", name: "Fruit", photo: "https://toppng.com/uploads/preview/fruits-11549675139aaf5iezif5.png"),
                          Category(id: "cat2", name: "Bevarage", photo: "https://toppng.com/uploads/preview/fruits-11549675139aaf5iezif5.png")]
    var vouchersList = [
                        Voucher(id: "vou1", discount: 10, allow: ["pr1", "cat1"], startDate: Date(), exp: Date(), amount: 3, photo: "https://cdn5.vectorstock.com/i/1000x1000/15/49/10-off-sale-discount-banner-discount-offer-price-vector-25621549.jpg"),
                        Voucher(id: "vou2", discount: 20, allow: ["cat2"], startDate: Date(), exp: Date(), amount: 2, photo: "https://cdn5.vectorstock.com/i/1000x1000/15/49/10-off-sale-discount-banner-discount-offer-price-vector-25621549.jpg")]
    
    init(delegate: HomeViewModelEvents) {
        self.delegate = delegate
    }
    
    func getCurrentPosition() -> String {
        return "Your position"
    }
    
    func getPosition() -> String {
        return ""
    }
    
    func loadHighlyRecommendedList() {
        
    }
    
    func loadBestSellingList() {
        
    }
    
    func loadGroceriesList() {
        
    }
    
    func loadCategoriesList() {
        
    }
}
