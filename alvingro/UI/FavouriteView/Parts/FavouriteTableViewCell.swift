//
//  FavouriteTableViewCell.swift
//  alvingro
//
//  Created by Thành Nguyên on 28/05/2021.
//

import UIKit

class FavouriteTableViewCell: UITableViewCell {
  
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var unitLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
      
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        photoImageView.image = UIImage(named: "PlaceholderImage")
        productNameLabel.text = nil
        unitLabel.text =  nil
        priceLabel.text =  nil
    }
    func bindData(product: Product) {
        photoImageView.getImageFromURL(url: product.photos?[0] ?? "", completionHandler: { img in
            if img == nil {
                self.photoImageView.image = UIImage(named: "PlaceholderImage")
            }
        })
        productNameLabel.text = product.name
        unitLabel.text = product.unit
        priceLabel.text = "$\(product.price ?? 0.00)"
    }
}
