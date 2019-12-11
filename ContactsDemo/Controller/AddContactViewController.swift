//
//  AddContactViewController.swift
//  ContactsDemo
//
//  Created by Prithvi Raj on 09/12/19.
//  Copyright © 2019 Prithvi Raj. All rights reserved.
//

import UIKit
import CoreData

protocol RefreshDelegate {
    func RefreshTblView()
}

class AddContactViewController: UIViewController {

    @IBOutlet weak var contactName: UITextField!
    @IBOutlet weak var contactNumber: UITextField!
    @IBOutlet weak var contactEmail: UITextField!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var ContainerView: UIView!
    
    var delegate: RefreshDelegate?
    let nscontext = ((UIApplication.shared.delegate) as!
        AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ViewSetup()
    }
    
   /// Function to setup view.
   fileprivate func ViewSetup() {
        self.view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).withAlphaComponent(0.5)
        contactEmail.LeftSpace()
        contactNumber.LeftSpace()
        contactName.LeftSpace()
        contactName.layer.cornerRadius = 5
        contactNumber.layer.cornerRadius = 5
        contactEmail.layer.cornerRadius = 5
        btnSave.layer.cornerRadius = 10
        ContainerView.layer.cornerRadius = 10
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setToolbarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setToolbarHidden(false, animated: false)
    }
    

    @IBAction func TapAction(_ sender: UITapGestureRecognizer) {
        self.dismiss(animated: true)
    }
    
    
    /// Function to save textfield data to core data
    /// It save data to Contacts Entity
    /// - Parameter sender: UIButton
    @IBAction func saveButtonClicked(_ sender: Any) {
        if contactName.text!.isEmpty || contactEmail.text!.isEmpty || contactNumber.text!.isEmpty {
            contactName.shake()
            contactNumber.shake()
            contactEmail.shake()
        } else {
            let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let entity = NSEntityDescription.entity(forEntityName: "Contacts", in: context)
            let contactsObject = NSManagedObject(entity: entity!, insertInto: context)
            
            contactsObject.setValue(contactName.text, forKey: "name")
            contactsObject.setValue(contactNumber.text, forKey: "number")
            contactsObject.setValue(contactEmail.text, forKey: "email")
            
            do {
                try context.save()
                print("saved")
                self.delegate?.RefreshTblView()
                self.dismiss(animated: true)
            } catch {
                print("not saving")
            }
        }
    }
}
