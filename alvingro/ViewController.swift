//
//  ViewController.swift
//  alvingro
//
//  Created by Thành Nguyên on 17/05/2021.
//

import UIKit
import Firebase
import RealmSwift

class ViewController: UIViewController {

    let db = Firestore.firestore()
    let storage = Storage.storage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "TestView"
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    @available(iOS 13.0, *)
    @IBAction func auth(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Auth", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: SignInViewController.identifier) as SignInViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func upDataButtonTapped(_ sender: Any) {
        let product = Product(id: "abc", photos: nil, name: "Test", amount: 2, price: 2.2, unit: "piece", details: "no comments", nutrition: nil, rate: 4.0, categories: ["cat1", "cat2"], brand: "nobrand")
        let jsonEncoder = JSONEncoder()
        do {
            let jsonData = try jsonEncoder.encode(product)
            let json = try JSONSerialization.jsonObject(with: jsonData, options: []) as! [String: Any]
            db.collection("products").document().setData(json)
        } catch let error {
            print("Error writing city to Firestore: \(error)")
        }
    }
    
    @IBAction func getProductsButtonTapped(_ sender: Any) {
        db.collection("products").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    let product = Product(snapshot: document)
                }
            }
        }
    }
    
    @IBAction func downloadPhotoButtonTapped(_ sender: Any) {
        // Create a reference to the file you want to download
//        let starsRef = storage.child("products/almond.png")
        
        
        let storageRef = storage.reference()
        
        let ref = storageRef.child("images/almond.png")

        // Fetch the download URL
        ref.downloadURL { url, error in
          if let error = error {
            print("$$$$ \(error)")
          } else {
            print(url)
          }
        }
            
    }
    
    
    func realmAddData() {
        guard let realm = try Realm() else { return }
        
        
    }
}
