//
//  SignUpViewController.swift
//  alvingro
//
//  Created by Thành Nguyên on 17/05/2021.
//

import UIKit

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var warningTextView: UITextView!
    
    lazy var viewModel = SignUpViewModel(delegate: self)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    func setupView() {
        
        navigationController?.setNavigationBarHidden(false, animated: true)
        emailTextField.underlined()
        
        passwordTextField.underlined()
        
        signupButton.mainButton()
        
    }
    
    @IBAction func signupButtonTapped(_ sender: Any) {
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        viewModel.signUp(email: email, password: password)
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension SignUpViewController: SignUpViewModelEvents {
    func signUpSuccess() {
        let alert = UIAlertController(title: "Success", message: "Create account successful", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func signUpFailed(error: Error) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    
}
