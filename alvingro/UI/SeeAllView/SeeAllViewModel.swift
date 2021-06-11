//
//  SeeAllViewModel.swift
//  alvingro
//
//  Created by Thành Nguyên on 07/06/2021.
//

import Foundation

protocol SeeAllViewModelEvents: AnyObject {
    func loadedData(by: String)
}


class SeeAllViewModel {
    weak var delegate: SeeAllViewModelEvents?
    
    var productsList = [Product]()
    
    init(delegate: SeeAllViewModelEvents) {
        self.delegate = delegate
    }
    
    func getDataFromDevice(by mode: String) {
        // mode: Highly recommended - Best selling - Categories - All products
        var title = ""
        let allProduct = LocalDatabase.shared.getAll(targetType: Product.self)
        
        switch mode {
        case "HighlyRecommended":
            productsList = allProduct.filter { $0.rate >= 4 }
            title = "Highly recommended"
        case "BestSelling":
            productsList = allProduct.filter { $0.amount < 10 }
            title = "Best selling"
        default: // Show by categories or show all products
            if LocalDatabase.shared.isExist(key: "id", value: mode, ofType: Category.self) {
                 // Show products of category
                productsList = allProduct.filter { $0.categories.contains(mode) }
                title = LocalDatabase.shared.getAnObject(key: "id", value: mode, ofType: Category.self)?.name ?? ""
            } else {
                //Show All products
                productsList = allProduct
                title = "All products"
            }
        }
        delegate?.loadedData(by: title)
    }
}
