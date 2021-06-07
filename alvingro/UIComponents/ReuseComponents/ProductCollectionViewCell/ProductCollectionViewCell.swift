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
    
    private var idProduct: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentView.layer.cornerRadius = 18
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor(white: 0.8, alpha: 1).cgColor
        
        addButton.layer.cornerRadius = 17
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        thumbImageView.image = UIImage(named: "PlaceholderImage")
        idProduct = nil
    }
    
    func bindData(product: Product) {
        thumbImageView.getImageFromURL(url: product.photos[0], completionHandler: { _ in ()})
        productNameLabel.text = product.name ?? ""
        unitLabel.text = product.unit ?? ""
        priceLabel.text = "$\(product.price)"
        idProduct = product.id
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        guard let idPro = idProduct else { return }
        LocalDatabase.shared.updateAmountCart(idProduct: idPro, amountOffset: 1)
    }
    
}
