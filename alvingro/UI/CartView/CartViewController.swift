//
//  CartViewController.swift
//  alvingro
//
//  Created by Thành Nguyên on 20/05/2021.
//

import UIKit

class CartViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var cartTableView: UITableView!
    @IBOutlet weak var checkoutButton: UIButton!
    @IBOutlet weak var totalPriceLabel: UILabel!
    
    //MARK: - Variables
    lazy var viewModel = CartViewModel(delegate: self)
    
    //MARK: Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cartTableView.delegate = self
        cartTableView.dataSource = self
        cartTableView.register(CartTableViewCell.nib, forCellReuseIdentifier: CartTableViewCell.identifier)
        cartTableView.tableFooterView = UIView()
        cartTableView.separatorInset = UIEdgeInsets(top: 0, left: 25, bottom: 0, right: 25)
        
        checkoutButton.mainButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getCartFromDevice()
    }

}

extension CartViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewModel.cartsList.count == 0 {
            cartTableView.setEmptyMessage("No thing")
        } else {
            cartTableView.restore()
        }
        return viewModel.cartsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CartTableViewCell.identifier, for: indexPath) as? CartTableViewCell else { return UITableViewCell() }
        cell.bindData(product: viewModel.productsList[indexPath.row], quantity: viewModel.cartsList[indexPath.row].amount)
        cell.delegate = self
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Show DetailsView
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        viewModel.deleteCart(index: indexPath.row)
    }
    
}

extension CartViewController: CartViewModelEvents {
    
    func updateCart(totalPrice: Float) {
        cartTableView.reloadData()
        totalPriceLabel.text = "$\(totalPrice)"
    }
    
    
    func updateCartAt(index: Int) {
        cartTableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
        totalPriceLabel.text = "$\(viewModel.reloadTotalPrice())"
    }
}

extension CartViewController: CartTableViewCellDelegate {
    func cartTableViewCell(_ cartTableViewCell: CartTableViewCell, updateAmount: Int) {
        guard let index = cartTableView.indexPath(for: cartTableViewCell)?.row else { return }
        viewModel.changeAmount(at: index, offsetValue: updateAmount)
    }
}
