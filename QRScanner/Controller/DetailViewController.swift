//
//  DetailViewController.swift
//  QRScanner
//
//  Created by KM, Abhilash a on 11/03/19.
//  Copyright © 2019 KM, Abhilash. All rights reserved.
//

import UIKit
import CoreData

class DetailViewController: UIViewController {

    @IBOutlet weak var detailLabel  : CopyLabel!
    @IBOutlet weak var quantity     : UITextField!
    @IBOutlet weak var warehouse    : UITextField!
    @IBOutlet weak var location     : UITextField!
    
    var qrData: QRData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailLabel.text = qrData?.codeString
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        self.view.addGestureRecognizer(tapGesture)

    }

    @IBAction func saveLocalStorage(_ sender: Any) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Item", in: managedContext)!
        
        let item  = NSManagedObject(entity: entity, insertInto: managedContext)
        
        item.setValue(detailLabel.text, forKey: "itemId")
        item.setValue(location.text, forKey: "location")
        item.setValue((quantity.text! as NSString).floatValue, forKey: "quantity")
        item.setValue(warehouse.text, forKey: "warehouse")
        item.setValue(Date(), forKey: "insertedAt")
        
        //TODO: Necessary Login
        item.setValue("KHIS", forKey: "user")
        
        do{
            try managedContext.save()
            self.navigationController?.popViewController(animated: true)
        } catch let error {
            print("Could not save \(error), \(error.localizedDescription)")
        }
        
    }
    
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
}
