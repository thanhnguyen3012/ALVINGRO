//
//  DetailsCollectionViewCell.swift
//  alvingro
//
//  Created by Thành Nguyên on 31/05/2021.
//

import UIKit

class DetailsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var photoImageView: UIImageView!
     
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        photoImageView.image = UIImage(named: "PlaceholderImage")
    }
    
    func bindData(url: String) {
        photoImageView.getImageFromURL(url: url, completionHandler: { img in
            if img == nil {
                self.photoImageView.image = UIImage(named: "PlaceholderImage")
            }
        })
    }

}
