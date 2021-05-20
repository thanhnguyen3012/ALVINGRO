//
//  SignInViewController.swift
//  alvingro
//
//  Created by Thành Nguyên on 17/05/2021.
//

import UIKit
import Firebase

class SignInViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    lazy var viewModel = SignInViewModel(delegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    func setupView() {
        emailTextField.underlined()
        
        passwordTextField.underlined()
        
        loginButton.mainButton()
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        viewModel.signIn(email: email, password: password)
    }
}

extension SignInViewController: SignInViewModelEvents {
    func signInSuccess() {
        print("SIGN IN SUCCESS")
        self.navigationController?.popViewController(animated: true)
    }
    
    func signInFailed(error: Error) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
