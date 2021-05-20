//
//  ProductCollectionViewCell.swift
//  alvingro
//
//  Created by Thành Nguyên on 20/05/2021.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var unitLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var addButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.contentView.layer.cornerRadius = 18
        self.contentView.layer.borderWidth = 1
        self.contentView.layer.borderColor = UIColor(white: 0.8, alpha: 1).cgColor
        
        addButton.layer.cornerRadius = 17
    }
    
    func bindData(product: Product) {
        thumbImageView.getImageFromURL(url: product.photos?[0] ?? "", completionHandler: { _ in ()})
        productNameLabel.text = product.name ?? ""
        unitLabel.text = product.unit ?? ""
        priceLabel.text = "$\(product.price ?? 0.00)"
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
    }
    
}
