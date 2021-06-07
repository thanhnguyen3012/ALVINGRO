//
//  SeeAllViewController.swift
//  alvingro
//
//  Created by Thành Nguyên on 07/06/2021.
//

import UIKit

class SeeAllViewController: UIViewController {

    //MARK: - Outlets
    @IBOutlet weak var productsCollectionView: UICollectionView!
    
    //MARK: - Variables
    lazy var viewModel = SeeAllViewModel(delegate: self)
    
    //MARK: - Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        navigationController?.setNavigationBarHidden(false, animated: true)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "Filter"), style: .plain, target: self, action: #selector(filterButtonTapped))
        
        productsCollectionView.delegate = self
        productsCollectionView.dataSource = self
        productsCollectionView.register(ProductCollectionViewCell.nib, forCellWithReuseIdentifier: ProductCollectionViewCell.identifier)
        
    }
    
    func initValue(keyWord: String){
        viewModel.getDataFromDevice(by: keyWord)
    }
    
    @objc func filterButtonTapped (sender:UIButton) {
        print("Filter tapped")
    }

}

extension SeeAllViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if viewModel.productsList.count == 0 {
            productsCollectionView.setEmptyMessage("No thing")
        } else {
            productsCollectionView.restore()
        }
        return viewModel.productsList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.identifier, for: indexPath) as? ProductCollectionViewCell else { return UICollectionViewCell() }
        cell.bindData(product: viewModel.productsList[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if #available(iOS 13.0, *) {
            guard let vc = self.storyboard?.instantiateViewController(identifier: DetailsViewController.identifier) as? DetailsViewController else { return }
            vc.initValue(product: viewModel.productsList[indexPath.row])
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: ((productsCollectionView.frame.width - 65) / 2), height: 250)
    }
}

extension SeeAllViewController: SeeAllViewModelEvents {
    func loadedData(by: String) {
        title = by
    }
}
