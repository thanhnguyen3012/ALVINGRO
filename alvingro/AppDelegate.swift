//
//  AppDelegate.swift
//  alvingro
//
//  Created by Thành Nguyên on 17/05/2021.
//

import UIKit
import Firebase
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        Firestore.firestore().settings = FirestoreSettings()
        return true
    }

    // MARK: UISceneSession Lifecycle

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "TestCoreData")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }


}

// MARK: - Fake data

let listCategories = [
    Category(id: "C000", name: "Cooking oil & ghee", photo: ""),
    Category(id: "C001", name: "Fruits & Vegetables", photo: ""),
    Category(id: "C002", name: "Meat & Fish", photo: ""),
    Category(id: "C003", name: "Bakery & Snack", photo: ""),
    Category(id: "C004", name: "Dairy & Eggs", photo: ""),
    Category(id: "C005", name: "Beverages", photo: ""),
    Category(id: "C006", name: "Spice", photo: ""),
    Category(id: "C007", name: "Dry food", photo: ""),
    Category(id: "C008", name: "Fastfood", photo: "")
]

let listProducts = [
    Product(id: nil, photos: ["https://firebasestorage.googleapis.com/v0/b/alvingro-1.appspot.com/o/images%2Falmond.png?alt=media&token=06f18d11-a40e-4e38-9a1d-aefb1cf26dc6", "https://firebasestorage.googleapis.com/v0/b/alvingro-1.appspot.com/o/images%2Falmond_1.png?alt=media&token=364f1f3a-44ee-4349-b46c-6eb803d5074e", "https://firebasestorage.googleapis.com/v0/b/alvingro-1.appspot.com/o/images%2Falmond_2.png?alt=media&token=a710d755-b0e4-4875-ad9a-727bdcc274d9"], name: "Almond", amount: 100, price: 4.5, unit: "1kg", details: "", nutrition: [], rate: 0, categories: ["C007"], brand: "B000"),
    Product(id: nil, photos: ["https://firebasestorage.googleapis.com/v0/b/alvingro-1.appspot.com/o/images%2Fapple.png?alt=media&token=86d7825b-18ec-482f-af49-76b527942ec1"], name: "Apple", amount: 20, price: 11.2, unit: "1kg", details: "", nutrition: [], rate: 0, categories: ["C001"], brand: "B000"),
    Product(id: nil, photos: ["https://firebasestorage.googleapis.com/v0/b/alvingro-1.appspot.com/o/images%2Fartichoke.png?alt=media&token=3612c48e-62e1-4799-b7c3-0d6390537de6", "https://firebasestorage.googleapis.com/v0/b/alvingro-1.appspot.com/o/images%2Fartichoke_1.png?alt=media&token=899aa321-4981-4a97-b776-2ba2831fcb43", "https://firebasestorage.googleapis.com/v0/b/alvingro-1.appspot.com/o/images%2Fartichoke_2.png?alt=media&token=f30a80b8-2f8e-470f-9264-e4a75d343b03"], name: "Artichoke", amount: 3, price: 2.1, unit: "piece", details: "", nutrition: [], rate: 0, categories: ["C001"], brand: "B000"),
    Product(id: nil, photos: ["https://firebasestorage.googleapis.com/v0/b/alvingro-1.appspot.com/o/images%2Fbacon.png?alt=media&token=646b624e-1aba-4025-8efb-0e60389bcc31", "https://firebasestorage.googleapis.com/v0/b/alvingro-1.appspot.com/o/images%2Fbacon_1.png?alt=media&token=b1c82c1c-ac82-4a23-8bff-a61334c003d2"], name: "Bacon", amount: 30, price: 30.4, unit: "1kg", details: "", nutrition: [], rate: 0, categories: ["C002"], brand: "B000"),
    Product(id: nil, photos: ["https://firebasestorage.googleapis.com/v0/b/alvingro-1.appspot.com/o/images%2Fbanana.png?alt=media&token=b4d4ddd2-870f-4709-88c4-643322b3750f", "https://firebasestorage.googleapis.com/v0/b/alvingro-1.appspot.com/o/images%2Fbanana_1.png?alt=media&token=367cb85c-1cbd-47ee-a373-8f17acf1244a", "https://firebasestorage.googleapis.com/v0/b/alvingro-1.appspot.com/o/images%2Fbanana_2.png?alt=media&token=43c434b0-4481-42ee-81d1-971f4f2caa2e"], name: "Banana", amount: 80, price: 20.3, unit: "1kg", details: "", nutrition: [], rate: 0, categories: ["C001"], brand: "B000"),
    Product(id: nil, photos: ["https://firebasestorage.googleapis.com/v0/b/alvingro-1.appspot.com/o/images%2Fbeef_hambuger.png?alt=media&token=fe2f00d5-c22a-4c8a-a269-d2bcbaf75faf"], name: "Beef Hambuger", amount: 30, price: 11.0, unit: "piece", details: "", nutrition: [], rate: 0, categories: ["C008"], brand: "B001"),
    Product(id: nil, photos: ["https://firebasestorage.googleapis.com/v0/b/alvingro-1.appspot.com/o/images%2Fbeetroot.png?alt=media&token=a6f9d23e-2856-472e-bf9c-a891b2af757e", "https://firebasestorage.googleapis.com/v0/b/alvingro-1.appspot.com/o/images%2Fbeetroot_1.png?alt=media&token=58b06453-d9f7-49c4-9103-8dff524b3b63"], name: "Beetroot", amount: 20, price: 1.2, unit: "1kh", details: "", nutrition: [], rate: 0, categories: ["C001"], brand: "B000")
]

let listBrands = [
    Brand(id: "B000", name: "Nobrand"),
    Brand(id: "B001", name: "KFC")
]

let listVouchers = [
    Voucher(id: nil, discount: 10, allow: ["C001"], startDate: Date(), exp: Date(), amount: 50, photo: ""),
    Voucher(id: nil, discount: 15, allow: ["C005", "C008"], startDate: Date(), exp: Date(), amount: 20, photo: "")
]
