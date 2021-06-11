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
    lazy var viewModel = EditUserViewModel(delegate: self)
    
    //MARK: - Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        navigationController?.setNavigationBarHidden(false, animated: true)
        
        title = "Edit your profile"
        
        photoImageView.layer.cornerRadius = ((photoImageView.frame.width - 10) / 2)
        photoImageView.image = viewModel.getCurrentImage()
        
        nameTextField.underlined()
        nameTextField.text = viewModel.getCurrentName()
        
        emailTextField.underlined()
        emailTextField.text = viewModel.getCurrentEmail()
        
        phoneTextField.underlined()
        phoneTextField.text = viewModel.getCurrentPhone()
        
        addressTextField.underlined()
        addressTextField.text = viewModel.getCurrentAddress()
        
        saveButton.mainButton()
        
    }
    
    //MARK: - Actions
    @IBAction func saveButtonTapped(_ sender: Any) {
        viewModel.saveChange(name: nameTextField.text, email: emailTextField.text, phone: phoneTextField.text, address: addressTextField.text)
    }
    
}

extension EditUserViewController: EditUserViewModelEvents{
    func userProfileSaved() {
        navigationController?.popViewController(animated: true)
    }
}
