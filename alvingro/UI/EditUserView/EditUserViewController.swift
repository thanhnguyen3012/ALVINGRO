//
//  EditUserViewController.swift
//  alvingro
//
//  Created by Thành Nguyên on 07/06/2021.
//

import UIKit

class EditUserViewController: UIViewController {
    //MARK: - Outlets
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    //MARK: - Variables
    
    //MARK: - Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        photoImageView.layer.cornerRadius = ((photoImageView.frame.width - 10) / 2)
        
        nameTextField.underlined()
        
        emailTextField.underlined()
        
        phoneTextField.underlined()
        
        addressTextField.underlined()
        
        saveButton.mainButton()
        
    }
    
    //MARK: - Actions

}
