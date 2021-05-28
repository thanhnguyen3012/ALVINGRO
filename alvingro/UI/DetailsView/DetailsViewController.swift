//
//  DetailsViewController.swift
//  alvingro
//
//  Created by Thành Nguyên on 28/05/2021.
//

import UIKit

class DetailsViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var photosCollectionView: UICollectionView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var loveButton: UIButton!
    @IBOutlet weak var unitLabel: UILabel!
    @IBOutlet weak var decreaseButton: UIButton!
    @IBOutlet weak var increaseButton: UIButton!
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var expandDetailsButton: UIButton!
    @IBOutlet weak var detailsTextView: UITextView!
    @IBOutlet weak var expandNutritionButton: UIButton!
    @IBOutlet weak var nutritionTextView: UITextView!
    @IBOutlet weak var expandReviewButton: UIButton!
    @IBOutlet var ratingStarsArrayImageView: [UIImageView]!
    @IBOutlet weak var addToBasketButton: UIButton!
    
    // MARK: - Variables
    lazy var viewModel = DetailsViewModel(delegate: self)
    
    // MARK: - Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        photosCollectionView.delegate = self
        photosCollectionView.dataSource = self
        
        productNameLabel.text = viewModel.product.name
        
        loveButton.setImage(UIImage(named: "Love-highlighted"), for: .selected)
        loveButton.setImage(UIImage(named: "Love"), for: .normal)
        
        unitLabel.text = viewModel.product.unit
        
        decreaseButton.setImage(UIImage(named: "Minus-active"), for: .normal)
        decreaseButton.setImage(UIImage(named: "Minus-unactive"), for: .disabled)
        
        increaseButton.setImage(UIImage(named: "Plus-active"), for: .normal)
        increaseButton.setImage(UIImage(named: "Plus-unactive"), for: .disabled)
        
        amountTextField.layer.cornerRadius = 17
        amountTextField.layer.borderWidth = 1
        amountTextField.layer.borderColor = UIColor.gray.cgColor
        
        priceLabel.text = "$\(viewModel.product.price ?? 0.00)"
        
        detailsTextView.text = viewModel.product.details
        
        nutritionTextView.text = viewModel.getNutritionString()
        
        setupRatingPoint(rating: viewModel.product.rate ?? 0)
        
        addToBasketButton.mainButton()
    }
    
    func setupRatingPoint(rating: Float) {
        var point = rating
        let maxPoint = Float(ratingStarsArrayImageView.count)
        while point > maxPoint {
            point -= maxPoint
        }
        
        for i in 0..<Int(ratingStarsArrayImageView.count) {
            ratingStarsArrayImageView[i].image = i < Int(point) ? UIImage(named: "Star-highlighted") : UIImage(named: "Star")
        }
    }
    
    //MARK: - Actions
    
    @IBAction func loveButtonTapped(_ sender: Any) {
    }
    @IBAction func decreaseButtonTapped(_ sender: Any) {
    }
    @IBAction func increaseButtonTapped(_ sender: Any) {
    }
    @IBAction func expandDetailsButtonTapped(_ sender: Any) {
    }
    @IBAction func expandNutritionButtonTapped(_ sender: Any) {
    }
    @IBAction func addToBasketButtonTapped(_ sender: Any) {
    }
}

extension DetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        <#code#>
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        <#code#>
    }
}

extension DetailsViewController: DetailsViewModelEvents {
    
}
