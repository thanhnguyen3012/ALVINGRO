//
//  CheckoutViewController.swift
//  alvingro
//
//  Created by Thành Nguyên on 10/06/2021.
//

import UIKit

protocol CheckoutViewControllerDelegate: AnyObject {
    func checkoutSuccess(order: Order)
    func checkoutFail(reason: String)
}

class CheckoutViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var extendAddressButton: UIButton!
    @IBOutlet weak var inputAddressView: UIView!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var paymentLabel: UILabel!
    @IBOutlet weak var discountLabel: UILabel!
    @IBOutlet weak var extendDiscountButton: UIButton!
    @IBOutlet weak var inputDiscountView: UIView!
    @IBOutlet weak var voucherTextField: UITextField!
    @IBOutlet weak var totalCostLabel: UILabel!
    @IBOutlet weak var termTextView: UITextView!
    @IBOutlet weak var checkoutButton: UIButton!
    @IBOutlet weak var checkoutFormView: UIView!
    
    // MARK: - Variables
    lazy var viewModel = CheckoutViewModel(delegate: self)
    weak var delegate: CheckoutViewControllerDelegate?
    
    // MARK: - Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    func setupView() {
        //UI setup
        checkoutFormView.layer.cornerRadius = 20
        checkoutFormView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        extendAddressButton.setImage(UIImage(named: "Next"), for: .normal)
        extendAddressButton.setImage(UIImage(named: "Dropdown"), for: .selected)
        extendAddressButton.isSelected = false
        
        extendDiscountButton.setImage(UIImage(named: "Next"), for: .normal)
        extendDiscountButton.setImage(UIImage(named: "Dropdown"), for: .selected)
        extendDiscountButton.isSelected = false
        
        inputAddressView.isHidden = true
        
        inputDiscountView.isHidden = true
        
        let termText = NSMutableAttributedString(string: "By placing an order you agree to our\nTerms And Conditions")
        termText.addAttribute(.foregroundColor, value: UIColor.gray, range: NSRange(location: 0, length: termText.length))
        termText.addAttribute(.foregroundColor, value: UIColor(named: "MainGreen") ?? .green, range: NSRange(location: 37, length: 5))
        termText.addAttribute(.foregroundColor, value: UIColor(named: "MainGreen") ?? .green, range: NSRange(location: 47, length: 10))
        termTextView.text = nil
        termTextView.attributedText = termText
        
        checkoutButton.mainButton()
        
        // fill contents
        addressLabel.text = viewModel.order.address ?? "Pick address"
        paymentLabel.text = viewModel.order.paymentMethod
        discountLabel.text = viewModel.order.voucher != nil ? viewModel.order.voucher : "Enter discount"
        totalCostLabel.text = "$\(viewModel.order.finalCost)"
    }
    
    func initValue(order: Order) {
        viewModel.setData(order: order)
    }
    
    // MARK: - Actions
    
    @IBAction func extendAddressButtonTapped(_ sender: Any) {
        extendAddressButton.isSelected = !extendAddressButton.isSelected
        inputAddressView.isHidden = !extendAddressButton.isSelected
    }
    
    @IBAction func extendDiscountButtonTapped(_ sender: Any) {
        extendDiscountButton.isSelected = !extendDiscountButton.isSelected
        inputDiscountView.isHidden = !extendDiscountButton.isSelected
    }
    
    @IBAction func enterCodeButtonTapped(_ sender: Any) {
        //Enter the promo code
        viewModel.checkPromo(code: voucherTextField.text ?? "")
    }
    
    @IBAction func saveAddressButtonTapped(_ sender: Any) {
        addressLabel.text = addressTextField.text != nil ? addressTextField.text : "Pick address"
        addressTextField.text = nil
        inputAddressView.isHidden = true
    }
    
    @IBAction func checkoutButtonTapped(_ sender: Any) {
        viewModel.checkout()
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

extension CheckoutViewController: CheckoutViewModelEvents {
    func updateTotalPrice(price: Float) {
        totalCostLabel.text = "$\(price)"
    }
    
    func updatePromo(discountPercent: Float) {
        discountLabel.text = discountPercent == 0 ? "Enter discount" : "-\(discountPercent)"
        inputDiscountView.isHidden = true
    }
    
    func checkoutSuccess(order: Order) {
        dismiss(animated: true, completion: nil)
        delegate?.checkoutSuccess(order: order)
    }
    
    func checkoutFail(reason: String) {
        dismiss(animated: true, completion: nil)
        delegate?.checkoutFail(reason: reason)
    }
}
