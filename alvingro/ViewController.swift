//
//  ViewController.swift
//  alvingro
//
//  Created by Thành Nguyên on 17/05/2021.
//

import UIKit
import Firebase
import RealmSwift
import FirebaseFirestore

class ViewController: UIViewController {

    let db = Firestore.firestore()
    let storage = Storage.storage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "TestView"
        navigationController?.setNavigationBarHidden(false, animated: true)
        
        //Run realm test
        realmAddData()
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
            print(url?.absoluteString ?? "")
          }
        }
            
    }
    
    let listProducts = [
        Product(id: "PR001", photos: ["https://firebasestorage.googleapis.com/v0/b/alvingro-1.appspot.com/o/images%2Falmond.png?alt=media&token=06f18d11-a40e-4e38-9a1d-aefb1cf26dc6", "https://firebasestorage.googleapis.com/v0/b/alvingro-1.appspot.com/o/images%2Falmond_1.png?alt=media&token=364f1f3a-44ee-4349-b46c-6eb803d5074e", "https://firebasestorage.googleapis.com/v0/b/alvingro-1.appspot.com/o/images%2Falmond_2.png?alt=media&token=a710d755-b0e4-4875-ad9a-727bdcc274d9"], name: "Almond", amount: 100, price: 4.5, unit: "1kg", details: "The almond fruit is 3.5–6 cm (1+3⁄8–2+3⁄8 in) long. In botanical terms, it is not a nut but a drupe. The outer covering or exocarp, fleshy in other members of Prunus such as the plum and cherry, is instead a thick, leathery, grey-green coat (with a downy exterior), called the hull. Inside the hull is a reticulated, hard, woody shell (like the outside of a peach pit) called the endocarp. Inside the shell is the edible seed, commonly called a nut. Generally, one seed is present, but occasionally two occur. After the fruit matures, the hull splits and separates from the shell, and an abscission layer forms between the stem and the fruit so that the fruit can fall from the tree.", nutrition: ["Almonds are 4% water, 22% carbohydrates, 21% protein, and 50% fat (table). In a 100-gram (3+1⁄2-ounce) reference amount, almonds supply 2,420 kilojoules (579 kilocalories) of food energy. The almond is a nutritionally dense food (table), providing a rich source (20% or more of the Daily Value, DV) of the B vitamins riboflavin and niacin, vitamin E, and the essential minerals calcium, copper, iron, magnesium, manganese, phosphorus, and zinc. Almonds are a moderate source (10–19% DV) of the B vitamins thiamine, vitamin B6, and folate, choline, and the essential mineral potassium. They also contain substantial dietary fiber, the monounsaturated fat, oleic acid, and the polyunsaturated fat, linoleic acid. Typical of nuts and seeds, almonds are a source of phytosterols such as beta-sitosterol, stigmasterol, campesterol, sitostanol, and campestanol."], rate: 3, categories: ["C007"], brand: "B000"),
        Product(id: "PR002", photos: ["https://firebasestorage.googleapis.com/v0/b/alvingro-1.appspot.com/o/images%2Fapple.png?alt=media&token=86d7825b-18ec-482f-af49-76b527942ec1"], name: "Apple", amount: 20, price: 11.2, unit: "1kg", details: "The apple is a deciduous tree, generally standing 2 to 4.5 m (6 to 15 ft) tall in cultivation and up to 9 m (30 ft) in the wild. When cultivated, the size, shape and branch density are determined by rootstock selection and trimming method. The leaves are alternately arranged dark green-colored simple ovals with serrated margins and slightly downy undersides.", nutrition: ["A raw apple is 86% water and 14% carbohydrates, with negligible content of fat and protein (table). A reference serving of a raw apple with skin weighing 100 grams provides 52 calories and a moderate content of dietary fiber.[70] Otherwise, there is low content of micronutrients, with the Daily Values of all falling below 10%, indicating a nutritionally poor food source."], rate: 4.6, categories: ["C001"], brand: "B000"),
        Product(id: "PR003", photos: ["https://firebasestorage.googleapis.com/v0/b/alvingro-1.appspot.com/o/images%2Fartichoke.png?alt=media&token=3612c48e-62e1-4799-b7c3-0d6390537de6", "https://firebasestorage.googleapis.com/v0/b/alvingro-1.appspot.com/o/images%2Fartichoke_1.png?alt=media&token=899aa321-4981-4a97-b776-2ba2831fcb43", "https://firebasestorage.googleapis.com/v0/b/alvingro-1.appspot.com/o/images%2Fartichoke_2.png?alt=media&token=f30a80b8-2f8e-470f-9264-e4a75d343b03"], name: "Artichoke", amount: 3, price: 2.1, unit: "piece", details: "This vegetable grows to 1.4–2 m (4 ft 7 in–6 ft 7 in) tall, with arching, deeply lobed, silvery, glaucous-green leaves 50–83 cm (19+1⁄2–32+1⁄2 in) long. The flowers develop in a large head from an edible bud about 8–15 cm (3–6 in) diameter with numerous triangular scales; the individual florets are purple. The edible portions of the buds consist primarily of the fleshy lower portions of the involucral bracts and the base, known as the heart; the mass of immature florets in the center of the bud is called the choke or beard. These are inedible in older, larger flowers.", nutrition: ["Energy 74kcal", "Carbonhydrates 11.557g", "Fat 2.87g", "Protein 2.81g", "Vitamins: A, B1, B2, B3, B6, C, K", "Minerals"], rate: 0, categories: ["C001"], brand: "B000"),
        Product(id: "PR004", photos: ["https://firebasestorage.googleapis.com/v0/b/alvingro-1.appspot.com/o/images%2Fbacon.png?alt=media&token=646b624e-1aba-4025-8efb-0e60389bcc31", "https://firebasestorage.googleapis.com/v0/b/alvingro-1.appspot.com/o/images%2Fbacon_1.png?alt=media&token=b1c82c1c-ac82-4a23-8bff-a61334c003d2"], name: "Bacon", amount: 30, price: 30.4, unit: "1kg", details: """
            Bacon is a type of salt-cured pork[1] made from various cuts, typically from the pork belly or from the less fatty back cuts. It is eaten on its own, as a side dish (particularly in breakfasts), or used as a minor ingredient to flavour dishes (e.g., the club sandwich). Bacon is also used for barding and larding roasts, especially game, including venison and pheasant, and may also be used to insulate or flavour roast joints by being layered onto the meat. The word is derived from the Old High German Bahho, meaning "buttock", "ham" or "side of bacon", and is cognate with the Old French bacon.[2][3] It may also be distantly cognate with modern German Bauch, meaning "abdomen, belly".
            Meat from other animals, such as beef, lamb, chicken, goat, or turkey, may also be cut, cured, or otherwise prepared to resemble bacon, and may even be referred to as, for example, "turkey bacon".[5] Such use is common in areas with significant Jewish and Muslim populations as both religions prohibit the consumption of pork.[6] Vegetarian bacons such as "soy bacon" also exist.
""", nutrition: ["One 10-g slice of cooked side bacon contains 4.5 g of fat, 3.0 g of protein, and 205 mg of sodium.[54] The fat, protein, and sodium content varies depending on the cut and cooking method.", "68% of the food energy of bacon comes from fat, almost half of which is saturated. A serving of three slices of bacon contains 30 milligrams of cholesterol (0.1%)."], rate: 4, categories: ["C002"], brand: "B000"),
        Product(id: "PR005", photos: ["https://firebasestorage.googleapis.com/v0/b/alvingro-1.appspot.com/o/images%2Fbanana.png?alt=media&token=b4d4ddd2-870f-4709-88c4-643322b3750f", "https://firebasestorage.googleapis.com/v0/b/alvingro-1.appspot.com/o/images%2Fbanana_1.png?alt=media&token=367cb85c-1cbd-47ee-a373-8f17acf1244a", "https://firebasestorage.googleapis.com/v0/b/alvingro-1.appspot.com/o/images%2Fbanana_2.png?alt=media&token=43c434b0-4481-42ee-81d1-971f4f2caa2e"], name: "Banana", amount: 8, price: 20.3, unit: "1kg", details: "A banana is an elongated, edible fruit – botanically a berry[1][2] – produced by several kinds of large herbaceous flowering plants in the genus Musa.[3] In some countries, bananas used for cooking may be called \"plantains\", distinguishing them from dessert bananas. The fruit is variable in size, color, and firmness, but is usually elongated and curved, with soft flesh rich in starch covered with a rind, which may be green, yellow, red, purple, or brown when ripe. The fruits grow in clusters hanging from the top of the plant. Almost all modern edible seedless (parthenocarp) bananas come from two wild species – Musa acuminata and Musa balbisiana. The scientific names of most cultivated bananas are Musa acuminata, Musa balbisiana, and Musa × paradisiaca for the hybrid Musa acuminata × M. balbisiana, depending on their genomic constitution. The old scientific name for this hybrid, Musa sapientum, is no longer used.", nutrition: ["Raw bananas (not including the peel) are 75% water, 23% carbohydrates, 1% protein, and contain negligible fat. A 100-gram reference serving supplies 89 Calories, 31% of the US recommended Daily Value (DV) of vitamin B6, and moderate amounts of vitamin C, manganese and dietary fiber, with no other micronutrients in significant content (see table)."], rate: 0, categories: ["C001"], brand: "B000"),
        Product(id: "PR006", photos: ["https://firebasestorage.googleapis.com/v0/b/alvingro-1.appspot.com/o/images%2Fbeef_hambuger.png?alt=media&token=fe2f00d5-c22a-4c8a-a269-d2bcbaf75faf"], name: "Beef Hambuger", amount: 6, price: 11.0, unit: "piece", details: "McDonald's Quarter Pounder® with Cheese Deluxe is a fresh take on a Quarter Pounder® classic burger. Crisp leaf lettuce and three Roma tomato slices top a ¼ lb.* of 100% McDonald’s fresh beef that’s hot, deliciously juicy and cooked when you order. Seasoned with just a pinch of salt and pepper and sizzled on our flat iron grill. Layered with two slices of melty American cheese, creamy mayo, slivered onions and tangy pickles on a soft, fluffy sesame seed hamburger bun. There are 630 calories in a Quarter Pounder with Cheese Deluxe. Grab your QPC Deluxe through the drive thru or with McDonald's curbside pickup when you Mobile Order & Pay! McDonald's App download and registration required.", nutrition: ["630 kcal"], rate: 4.2, categories: ["C008"], brand: "B001"),
        Product(id: "PR007", photos: ["https://firebasestorage.googleapis.com/v0/b/alvingro-1.appspot.com/o/images%2Fbeetroot.png?alt=media&token=a6f9d23e-2856-472e-bf9c-a891b2af757e", "https://firebasestorage.googleapis.com/v0/b/alvingro-1.appspot.com/o/images%2Fbeetroot_1.png?alt=media&token=58b06453-d9f7-49c4-9103-8dff524b3b63"], name: "Beetroot", amount: 20, price: 1.2, unit: "1kh", details: "The beetroot is the taproot portion of a beet plant,[1] usually known in Canada and the USA as beets while the vegetable is referred to as beetroot in British English, and also known as the table beet, garden beet, red beet, dinner beet or golden beet. It is one of several cultivated varieties of Beta vulgaris grown for their edible taproots and leaves (called beet greens); they have been classified as B. vulgaris subsp. vulgaris Conditiva Group.", nutrition: ["No infomation."], rate: 0, categories: ["C001"], brand: "B000")
    ]

    let listCategories = [
        Category(id: "C000", name: "Cooking oil & ghee", photo: "https://firebasestorage.googleapis.com/v0/b/alvingro-1.appspot.com/o/category_thumb%2FC000Oil.png?alt=media&token=3b52832a-a283-4df7-880d-1a6119718600"),
        Category(id: "C001", name: "Fruits & Vegetables", photo: "https://firebasestorage.googleapis.com/v0/b/alvingro-1.appspot.com/o/category_thumb%2FC001FruiVegetables.png?alt=media&token=e317ebf1-c9d1-4bef-8bbc-b59091cb3f5d"),
        Category(id: "C002", name: "Meat & Fish", photo: "https://firebasestorage.googleapis.com/v0/b/alvingro-1.appspot.com/o/category_thumb%2FC002MeatFish.png?alt=media&token=dd9d66ae-b955-46eb-b997-10a0b832b63d"),
        Category(id: "C003", name: "Bakery & Snack", photo: "https://firebasestorage.googleapis.com/v0/b/alvingro-1.appspot.com/o/category_thumb%2FC003BakerySnack.png?alt=media&token=90ec050e-8720-47d1-a02e-3aaa8c43de7c"),
        Category(id: "C004", name: "Dairy & Eggs", photo: "https://firebasestorage.googleapis.com/v0/b/alvingro-1.appspot.com/o/category_thumb%2FC004DairyEgg.png?alt=media&token=6d7e77ee-6a92-4f9e-9f57-07f48587d278"),
        Category(id: "C005", name: "Beverages", photo: "https://firebasestorage.googleapis.com/v0/b/alvingro-1.appspot.com/o/category_thumb%2FC005Beverages.png?alt=media&token=d5f04d5f-4400-49e4-8bce-3df9fffa2938"),
        Category(id: "C006", name: "Spice", photo: "https://firebasestorage.googleapis.com/v0/b/alvingro-1.appspot.com/o/category_thumb%2FC006Spice.png?alt=media&token=bc825dc8-0665-4f70-9cd4-c1691906e099"),
        Category(id: "C007", name: "Dry food", photo: "https://firebasestorage.googleapis.com/v0/b/alvingro-1.appspot.com/o/category_thumb%2FC007dryfood.png?alt=media&token=b2f2e57a-398c-453b-8df8-88f5bfe22829"),
        Category(id: "C008", name: "Fastfood", photo: "https://firebasestorage.googleapis.com/v0/b/alvingro-1.appspot.com/o/category_thumb%2FC008Fastfood.png?alt=media&token=2425a120-b7ab-4630-887a-a8d0499809c9")
    ]

    let listBrands = [
        Brand(id: "B000", name: "Nobrand"),
        Brand(id: "B001", name: "KFC")
    ]

    let listVouchers = [
        Voucher(id: "VC000", discount: 50, allow: ["C001"], startDate: Date(), exp: Date(), amount: 50, photo: "https://i.pinimg.com/736x/c9/54/d8/c954d8eae99a43acf2f995afe501e028.jpg"),
        Voucher(id: "VC001", discount: 15, allow: ["C005", "C008"], startDate: Date(), exp: Date(), amount: 20, photo: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRnQkS1j9nnnWT8ogrbu7ke2vW41rRyCfXFpA&usqp=CAU")
    ]

    
    func realmAddData() {
        guard let realm = try? Realm() else {
            print("Realm fail")
            return

        }
        try! realm.write {
            realm.deleteAll()
        }
        print("Realm have been deleted.")
        /* app to realm */
        for product in listProducts {
            try! realm.write {
                realm.add(product)
            }
        }
        print("Realm have been written.")
        
        
        for category in listCategories {
            try! realm.write {
                realm.add(category)
            }
        }
        print("Realm have been written.")
        
        for voucher in listVouchers {
            try! realm.write {
                realm.add(voucher)
            }
        }
        print("Realm have been written.")
        
        for brand in listBrands {
            try! realm.write {
                realm.add(brand)
            }
        }
        print("Realm have been written.")
    }
    
    @IBAction func updateDataToFirebase(_ sender: Any) {
//        for product in listProducts {
//            LocalDatabase.shared.upAnObjectToFirebase(product, collection: "Product", id: product.id)
//        }
//
//        for voucher in listVouchers {
//            LocalDatabase.shared.upAnObjectToFirebase(voucher, collection: "Voucher", id: voucher.id)
//        }
//
        for brand in listBrands {
            LocalDatabase.shared.upAnObjectToFirebase(brand, collection: "Brand", id: brand.id)
        }
        
        for cat in listCategories {
            LocalDatabase.shared.upAnObjectToFirebase(cat, collection: "Category", id: cat.id)
        }
    }
}
