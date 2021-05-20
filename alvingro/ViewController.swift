//
//  ViewController.swift
//  alvingro
//
//  Created by Thành Nguyên on 17/05/2021.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "TestView"
        view.backgroundColor = UIColor(named: "MainGreen")
    }
    
    @available(iOS 13.0, *)
    @IBAction func auth(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Auth", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: SignInViewController.identifier) as SignInViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

