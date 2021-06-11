//
//  OrderAcceptedViewController.swift
//  alvingro
//
//  Created by Thành Nguyên on 10/06/2021.
//

import UIKit

class OrderAcceptedViewController: UIViewController {

    @IBOutlet weak var backToCartButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    func setupView() {
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "BlurBackground") ?? UIImage())
        
        backToCartButton.mainButton()
    }

    @IBAction func backToCartButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

}
