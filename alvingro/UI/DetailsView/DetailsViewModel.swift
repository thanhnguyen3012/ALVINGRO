//
//  DetailsViewModel.swift
//  alvingro
//
//  Created by Thành Nguyên on 28/05/2021.
//

import Foundation

protocol DetailsViewModelEvents: AnyObject {
}

class DetailsViewModel {
    
    weak var delegate: DetailsViewModelEvents?
    var product: Product
    
    init(delegate: DetailsViewModelEvents) {
        self.delegate = delegate
    }
    
    func getNutritionString() -> String {
        guard let nutritions = product.nutrition else { return "" }
        var result = ""
        for nutri in nutritions {
            result += nutri + "\n"
        }
        return results
    }
}
