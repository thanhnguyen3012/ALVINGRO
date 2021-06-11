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
    
    var highlyRecommendedList = [Product]()
    var bestSellingList = [Product]()
    var groceriseList = [Product]()
    var categoriesList = [Category]()
    var vouchersList = [Voucher]()
    
    init(delegate: HomeViewModelEvents) {
        self.delegate = delegate
        getAllProductFromDevice()
    }
    
    func getAllProductFromDevice() {
        groceriseList = LocalDatabase.shared.getAll(targetType: Product.self)
        vouchersList = LocalDatabase.shared.getAll(targetType: Voucher.self)
        categoriesList = LocalDatabase.shared.getAll(targetType: Category.self)
        loadHighlyRecommendedList()
        loadBestSellingList()
        delegate?.loadedProducts()
    }
    
    func getPosition() -> String {
        return ""
    }
    
    func loadHighlyRecommendedList() {
        highlyRecommendedList = groceriseList.filter { $0.rate >= 4 }
    }
    
    func loadBestSellingList() {
        bestSellingList = groceriseList.filter { $0.amount < 10 }
    }
    
    func syncProduct() {
        LocalDatabase.shared.syncWithFirebase(ofType: Product.self, collection: "Product")
    }
    
    func downloadDataFromFirebase() {
        LocalDatabase.shared.downloadAllFromFirebase()
    }
}
