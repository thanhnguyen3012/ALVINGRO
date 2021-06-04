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
    @IBOutlet weak var searchBar: UISearchBar!
    
    //MARK: - Variables
    lazy var viewModel = ExploreViewModel(delegate: self)
    
    // MARK: - Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        searchBar.text = ""
        showCategoriesCollectionVew()
    }
    
    func setupView() {
        navigationController?.setNavigationBarHidden(false, animated: true)
        title = "Find Products"
        
        categoriesCollectionView.delegate = self
        categoriesCollectionView.dataSource = self
        categoriesCollectionView.register(CategoryCollectionViewCell.nib, forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
        
        searchResultCollectionView.delegate = self
        searchResultCollectionView.dataSource = self
        searchResultCollectionView.register(ProductCollectionViewCell.nib, forCellWithReuseIdentifier: ProductCollectionViewCell.identifier)
        
        searchBar.delegate = self
        searchBar.showsCancelButton = true
        
        searchBar.layer.borderWidth = 0
        searchBar.clipsToBounds = true
        searchBar.layer.cornerRadius = 15
        searchBar.layer.backgroundColor = UIColor(named: "BackGround-gray")?.cgColor
        searchBar.backgroundColor = UIColor(named: "BackGround-gray")

//        searchBar.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 52)
        if #available(iOS 13.0, *) {
            searchBar.searchTextField.backgroundColor = UIColor(named: "BackGround-gray")
            searchBar.searchTextField.frame.size.height = 52
            searchBar.searchTextField.frame.size.width = searchBar.frame.width - 50
        }
        
//        if let textField = searchBar.value(forKey: "searchField") as? UITextField {
//            textField.backgroundColor = .red
//            textField.layer.cornerRadius = 15
//            textField.layer.masksToBounds = true
//            textField.font = UIFont.systemFont(ofSize: 14, weight: .regular)
//            textField.textColor = .black
//            textField.frame = CGRect(x: 0, y: 0, width: self.view.frame.width - 50, height: 52)
//
//            let backgroundView = textField.subviews.first
//            if #available(iOS 11.0, *) { // If `searchController` is in `navigationItem`
//                backgroundView?.frame.size.height = 52
//                backgroundView?.backgroundColor = UIColor.white.withAlphaComponent(0.3) //Or any transparent color that matches with the `navigationBar color`
//                backgroundView?.subviews.forEach({ $0.removeFromSuperview() }) // Fixes an UI bug when searchBar appears or hides when scrolling
//            }
//            backgroundView?.layer.cornerRadius = 10.5
//            backgroundView?.layer.masksToBounds = true
//            //Continue changing more properties...
//        }
        
    }
    
    func showCategoriesCollectionVew() {
        categoriesCollectionView.isHidden = false
        searchResultCollectionView.isHidden = true
    }
    
    func showSearchResultCollectionView() {
        searchResultCollectionView.isHidden = false
        categoriesCollectionView.isHidden = true
    }
}

extension ExploreViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == categoriesCollectionView {
            //Set placeholder for collectionView when it empty
            if viewModel.categoriesList.count == 0 {
                collectionView.setEmptyMessage("No thing")
            } else {
                collectionView.restore()
            }
            return viewModel.categoriesList.count
        } else { // searchResultCollectionView
            //Set placeholder for collectionView when it empty
            if viewModel.resultsList.count == 0 {
                collectionView.setEmptyMessage("No thing")
            } else {
                collectionView.restore()
            }
            return viewModel.resultsList.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == categoriesCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifier, for: indexPath) as? CategoryCollectionViewCell else { return UICollectionViewCell() }
            cell.setCellColor(color: viewModel.getColor(index: indexPath.row))
            cell.bindData(category: viewModel.categoriesList[indexPath.row])
            return cell
        } else { // searchResultCollectionView
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.identifier, for: indexPath) as? ProductCollectionViewCell else { return UICollectionViewCell() }
            cell.bindData(product: viewModel.resultsList[indexPath.row])
            return cell
        }
    }
    
}

extension ExploreViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == categoriesCollectionView {
            // Show CategoryView
        } else {
            viewModel.resultSelected(atIndex: indexPath.row)
        }
    }
}

extension ExploreViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == categoriesCollectionView {
            return CGSize(width: ((collectionView.frame.width - 65) / 2), height: 190)
        }
        return CGSize(width: ((collectionView.frame.width - 63) / 2), height: 250)
    }
}

extension ExploreViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        showSearchResultCollectionView()
        viewModel.searchProducts(key: searchBar.text ?? "")
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        showCategoriesCollectionVew()
        searchBar.endEditing(true)
        viewModel.cancelSearchMode()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        showCategoriesCollectionVew()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        showSearchResultCollectionView()
    }
}

extension ExploreViewController: ExploreViewModelEvents {
    func showResultView(vc: DetailsViewController) {
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func loadedProducts() {
        searchResultCollectionView.reloadData()
    }
}
