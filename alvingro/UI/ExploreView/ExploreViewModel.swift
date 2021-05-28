//
//  ExploreViewModel.swift
//  alvingro
//
//  Created by Thành Nguyên on 28/05/2021.
//

import Foundation

protocol ExploreViewModelEvents: AnyObject {
}

class ExploreViewModel {
    weak var delegate: ExploreViewModelEvents?
    
    init(delegate: ExploreViewModelEvents) {
        self.delegate = delegate
    }
}
