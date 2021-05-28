//
//  ExploreViewController.swift
//  alvingro
//
//  Created by Thành Nguyên on 20/05/2021.
//

import UIKit

class ExploreViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var categoriesCollectionView: UICollectionView!
    @IBOutlet weak var searchResultCollectionView: UICollectionView!
    
    // MARK: - Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        categoriesCollectionView.delegate = self
        categoriesCollectionView.dataSource = self
        categoriesCollectionView.register(CategoryCollectionViewCell.nib, forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
        
        searchResultCollectionView.delegate = self
        searchResultCollectionView.dataSource = self
        searchResultCollectionView.register(ProductCollectionViewCell.nib, forCellWithReuseIdentifier: ProductCollectionViewCell.identifier)
    }
}

extension ExploreViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        <#code#>
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        <#code#>
    }
    
    
}
