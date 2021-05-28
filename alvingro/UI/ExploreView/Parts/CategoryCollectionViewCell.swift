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
    }
    
    func bindData(category: Category) {
        imageView.getImageFromURL(url: category.photo ?? "", completionHandler: { img in
            if img == nil {
                print("Category \"\(category.name ?? "")\" do not have photo.")
            }
        })
        nameLabel.text = category.name
    }

}
