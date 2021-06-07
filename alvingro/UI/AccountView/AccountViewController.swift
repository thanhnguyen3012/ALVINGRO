//
//  AccountViewController.swift
//  alvingro
//
//  Created by Thành Nguyên on 20/05/2021.
//

import UIKit

class AccountViewController: UIViewController {
 
    //MARK: - Outlets
    @IBOutlet weak var userPhotoImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var optionTableView: UITableView!
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var logoutImageView: UIImageView!
    
    //MARK: -Variables
    lazy var viewModel = AccountViewModel(delegate: self)
    
    //MARK: -Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.checkCurrentAccount()
    }
    
    func setupView() {
        navigationController?.setNavigationBarHidden(true, animated: true)
        
        optionTableView.delegate = self
        optionTableView.dataSource = self
        optionTableView.register(UserTableViewCell.nib, forCellReuseIdentifier: UserTableViewCell.identifier)
        optionTableView.tableFooterView = UIView()
        optionTableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    //MARK: - Actions
    
    @IBAction func logoutButtonTapped(_ sender: Any) {
        viewModel.loggout()
    }
    
}

extension AccountViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.optionList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserTableViewCell.identifier, for: indexPath) as? UserTableViewCell else { return UITableViewCell() }
        cell.setupCell(image: viewModel.getImageForTableViewAt(index: indexPath.row), title: viewModel.getTitleForTableViewCellAt(index: indexPath.row))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 62
    }
    
}

extension AccountViewController: AccountViewModelEvents {
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func noLoggedIn() {
        userPhotoImageView.image = UIImage(named: "PlaceholderImage")
        nameLabel.text = "Unknown"
        emailLabel.text = "Login to continue."
        
        let alert = UIAlertController(title: "No logged in", message: "Do you want to log in?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Log in", style: .default, handler:{(alert: UIAlertAction!) in
            let storyboard = UIStoryboard(name: "Auth", bundle: nil)
            if #available(iOS 13.0, *) {
                let vc = storyboard.instantiateViewController(identifier: SignInViewController.identifier) as SignInViewController
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true, completion: nil)
            }
        }))
        
        present(alert, animated: true, completion: nil)
    }
    
    func updateUserInfo(image: UIImage, name: String, email: String) {
        userPhotoImageView.image = image
        nameLabel.text = name
        emailLabel.text = email
    }
    
    
}
