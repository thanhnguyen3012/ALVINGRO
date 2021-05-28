//
//  FavoriteViewController.swift
//  alvingro
//
//  Created by Thành Nguyên on 20/05/2021.
//

import UIKit

class FavouriteViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var favouriteTableView: UITableView!
    @IBOutlet weak var addAllToCartButton: UIButton!
    
    //MARK: - Variables
    lazy var viewModel = FavouriteViewModel(delegate: self)
    
    //MARK: - Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        favouriteTableView.delegate = self
        favouriteTableView.dataSource = self
        favouriteTableView.register(FavouriteTableViewCell.nib, forCellReuseIdentifier: FavouriteTableViewCell.identifier)
        
        addAllToCartButton.mainButton()
    }

}

extension FavouriteViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.productsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
}

extension FavouriteViewController: FavouriteViewModelEvents {
    
}
