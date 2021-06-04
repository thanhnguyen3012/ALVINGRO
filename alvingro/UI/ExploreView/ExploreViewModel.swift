//
//  ExploreViewModel.swift
//  alvingro
//
//  Created by Thành Nguyên on 28/05/2021.
//

import UIKit

protocol ExploreViewModelEvents: AnyObject {
    func loadedProducts()
    func showResultView(vc: DetailsViewController)
}

class ExploreViewModel {
    weak var delegate: ExploreViewModelEvents?
    
    var resultsList = [Product]()
    var categoriesList = [Category]()
    
    init(delegate: ExploreViewModelEvents) {
        self.delegate = delegate
        getCategoriesFromDevice()
    }
    
    func getCategoriesFromDevice() {
        categoriesList = LocalDatabase.shared.getAll(targetType: Category.self)
    }
    
    func searchProducts(key keyWord: String) {
        let allProducts = LocalDatabase.shared.getAll(targetType: Product.self)
        resultsList = allProducts.filter { product in
            return (product.name?.lowercased().contains(keyWord.lowercased()) ?? false) || (keyWord.lowercased().contains((product.name?.lowercased())!))
        }
        delegate?.loadedProducts()
    }
    
    func cancelSearchMode() {
        resultsList.removeAll()
    }
    
    func resultSelected(atIndex index: Int) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if #available(iOS 13.0, *) {
            let vc = storyboard.instantiateViewController(identifier: DetailsViewController.identifier) as DetailsViewController
            vc.initValue(product: resultsList[index])
            delegate?.showResultView(vc: vc)
        }
    }
    
    // This function return background color for CategoriCollectionViewCell
    func getColor(index: Int) -> UIColor {
        return MyColor.get(index)
    }
}
