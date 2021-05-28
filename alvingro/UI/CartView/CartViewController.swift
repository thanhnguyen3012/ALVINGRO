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
    }

}

extension CartViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.productsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    
}

extension CartViewController: CartViewModelEvents {
    
}
