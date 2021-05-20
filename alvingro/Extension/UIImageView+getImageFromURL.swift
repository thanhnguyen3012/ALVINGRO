//
//  UIImageView+getImageFromURL.swift
//  alvingro
//
//  Created by Thành Nguyên on 20/05/2021.
//

import UIKit
import Kingfisher

extension UIImageView {
    
    func getImageFromURL(url stringUrl: String, completionHandler: @escaping (UIImage?) -> ()) {
        
        let url = URL(string: stringUrl)
        let processor = DownsamplingImageProcessor(size: self.bounds.size)
        
        self.kf.indicatorType = .activity
        self.kf.setImage(
            with: url,
            placeholder: UIImage(named: "PlaceholderImage"),
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
        {
            result in
            self.kf.indicatorType = .none
            switch result {
            case .success(let value):
                print("Task done for: \(value.source.url?.absoluteString ?? "")")
            case .failure(let error):
                print("Job failed: \(error.localizedDescription)")
            }
        }

    }
}
