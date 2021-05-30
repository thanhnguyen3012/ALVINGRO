//
//  FavoriteViewController.swift
//  alvingro
//
//  Created by Thành Nguyên on 20/05/2021.
//

import UIKit

class FavouriteViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var addAllToCartButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Variables
    lazy var viewModel = FavouriteViewModel(delegate: self)
    
    // MARK: - Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        addAllToCartButton.mainButton()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(FavouriteTableViewCell.nib, forCellReuseIdentifier: FavouriteTableViewCell.identifier)
    }

}

extension FavouriteViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.productsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard  let cell = tableView.dequeueReusableCell(withIdentifier: FavouriteTableViewCell.identifier, for: indexPath) as? FavouriteTableViewCell else {
            return UITableViewCell()
        }
        cell.bindData(product: viewModel.productsList[indexPath.row])
        return cell
    }
}

extension FavouriteViewController: FavouriteViewModelEvents {
    
}
