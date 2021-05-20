//
//  VoucherCollectionViewCell.swift
//  alvingro
//
//  Created by Thành Nguyên on 20/05/2021.
//

import UIKit

class VoucherCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var photoImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func bindData(voucher: Voucher) {
        photoImageView.getImageFromURL(url: voucher.photo ?? "", completionHandler: { _ in ()})
    }
}
