//
//  FavouriteViewModel.swift
//  alvingro
//
//  Created by Thành Nguyên on 30/05/2021.
//

import UIKit

protocol FavouriteViewModelEvents: AnyObject {
    func dataLoaded()
    func showDetailsView(vc: DetailsViewController)
}

class FavouriteViewModel {
    
    weak var delegate: FavouriteViewModelEvents?
    var productsList = [Product]()
    
    init(delegate: FavouriteViewModelEvents) {
        self.delegate = delegate
        getLikedListFromDevice()
    }
    
    func reloadData() {
        productsList.removeAll()
        getLikedListFromDevice()
    }
    
    func getLikedListFromDevice() {
        let likedList = LocalDatabase.shared.getAll(targetType: LikedProduct.self)
        for item in likedList {
            if let product = LocalDatabase.shared.getAnObject(key: "id", value: item.idProduct ?? "", ofType: Product.self) {
                productsList.append(product)
            }
        }
        delegate?.dataLoaded()
    }
    
    func remove(index: Int) {
        LocalDatabase.shared.removeAnObject(ofType: LikedProduct.self, key: "idProduct", value: productsList[index].id ?? "")
        productsList.remove(at: index)
        delegate?.dataLoaded()
    }
    
    @available(iOS 13.0, *)
    func selectAnItem(index: Int) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateViewController(identifier: DetailsViewController.identifier) as? DetailsViewController else { return }
        vc.initValue(product: productsList[index])
        delegate?.showDetailsView(vc: vc)
    }
}
