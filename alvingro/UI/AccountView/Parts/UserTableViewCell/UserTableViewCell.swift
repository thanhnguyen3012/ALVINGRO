//
//  UserTableViewCell.swift
//  alvingro
//
//  Created by Thành Nguyên on 07/06/2021.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        iconImageView.image = nil
    }
    
    func setupCell(image: UIImage, title: String) {
        iconImageView.image = image
        titleLabel.text = title
    }
    
}
