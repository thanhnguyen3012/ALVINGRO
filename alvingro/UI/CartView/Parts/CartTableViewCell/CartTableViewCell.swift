//
//  CartTableViewCell.swift
//  alvingro
//
//  Created by Thành Nguyên on 28/05/2021.
//

import UIKit

protocol CartTableViewCellDelegate {
    func cartTableViewCell(_ cartTableViewCell: CartTableViewCell, updateAmount: Int)
}

class CartTableViewCell: UITableViewCell {
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var unitLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var decreaseButton: UIButton!
    @IBOutlet weak var increaseButton: UIButton!
    @IBOutlet weak var priceLabel: UILabel!
    
    var delegate: CartTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        decreaseButton.setImage(UIImage(named: "Minus-unactive"), for: .disabled)
        decreaseButton.setImage(UIImage(named: "Minus-active"), for: .normal)
        decreaseButton.layer.borderWidth = 1
        decreaseButton.layer.borderColor = UIColor(named: "BackGround-gray")?.cgColor
        decreaseButton.layer.cornerRadius = 17
        
        increaseButton.setImage(UIImage(named: "Plus-unactive"), for: .disabled)
        increaseButton.setImage(UIImage(named: "Plus-active"), for: .normal)
        increaseButton.layer.borderWidth = 1
        increaseButton.layer.borderColor = UIColor(named: "BackGround-gray")?.cgColor
        increaseButton.layer.cornerRadius = 17
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        photoImageView.image = UIImage(named: "PlaceholderImage")
    }
    
    func bindData(product: Product, quantity: Int) {
        photoImageView.getImageFromURL(url: product.photos[0], completionHandler: { _ in })
        nameLabel.text = product.name
        unitLabel.text = product.unit
        amountLabel.text = "\(quantity)"
        priceLabel.text = "$\(product.price)"
        checkAmount(amount: quantity, maxAmount: product.amount)
    }
    
    @IBAction func decreaseButtonTapped(_ sender: Any) {
        delegate?.cartTableViewCell(self, updateAmount: -1)
    }
    
    @IBAction func increaseButtonTapped(_ sender: Any) {
        delegate?.cartTableViewCell(self, updateAmount: 1)
    }
    
    func checkAmount(amount: Int, maxAmount: Int) {
        decreaseButton.isEnabled = amount <= 1 ? false : true
        increaseButton.isEnabled = amount >= maxAmount ? false : true
    }
}
