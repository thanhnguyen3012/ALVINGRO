//
//  FavouriteViewModel.swift
//  alvingro
//
//  Created by Thành Nguyên on 28/05/2021.
//

import Foundation

protocol FavouriteViewModelEvents: AnyObject {
    
}

class FavouriteViewModel {
    
    weak var delegate: FavouriteViewModelEvents?
    var productsList = [Product]()
    
    init(delegate: FavouriteViewModelEvents) {
        self.delegate = delegate
    }
}
