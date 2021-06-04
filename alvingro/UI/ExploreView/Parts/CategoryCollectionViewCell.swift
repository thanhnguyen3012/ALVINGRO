//
//  CategoryCollectionViewCell.swift
//  alvingro
//
//  Created by Thành Nguyên on 28/05/2021.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.borderWidth = 1
        layer.cornerRadius = 18
    }
    
    override func prepareForReuse() {
        imageView.image = nil
    }
    
    func bindData(category: Category) {
        imageView.getImageFromURL(url: category.photo ?? "", completionHandler: { img in
            if img == nil {
                print("Category \"\(category.name ?? "")\" do not have photo.")
            }
        })
        nameLabel.text = category.name
    }
    
    func setCellColor(color: UIColor) {
        backgroundColor = color.withAlphaComponent(0.25)
        layer.borderColor = color.cgColor
    }

}
