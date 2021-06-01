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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.reloadData()
    }
    
    func setupView() {
        addAllToCartButton.mainButton()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(FavouriteTableViewCell.nib, forCellReuseIdentifier: FavouriteTableViewCell.identifier)
        tableView.tableFooterView = UIView()
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 25, bottom: 0, right: 25)
    }

}

extension FavouriteViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // Set placeholder for UITableView if needed
        if viewModel.productsList.count == 0 {
            tableView.setEmptyMessage("No thing")
        } else {
            tableView.restore()
        }
        
        return viewModel.productsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard  let cell = tableView.dequeueReusableCell(withIdentifier: FavouriteTableViewCell.identifier, for: indexPath) as? FavouriteTableViewCell else {
            return UITableViewCell()
        }
        cell.bindData(product: viewModel.productsList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        viewModel.remove(index: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if #available(iOS 13.0, *) {
            viewModel.selectAnItem(index: indexPath.row)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 157
    }
}

extension FavouriteViewController: FavouriteViewModelEvents {
    func dataLoaded() {
        tableView.reloadData()
    }
    
    func showDetailsView(vc: DetailsViewController) {
        navigationController?.pushViewController(vc, animated: true)
    }
}
