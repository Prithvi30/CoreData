//
//  DetailsViewController.swift
//  ContactsDemo
//
//  Created by Prithvi Raj on 11/12/19.
//  Copyright © 2019 Prithvi Raj. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var contactName: UILabel!
    @IBOutlet weak var contactNumber: UILabel!
    @IBOutlet weak var contactEmail: UILabel!
    
    var details: ContactItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        contactName.text = "\(details?.name ?? "Name")"
        contactNumber.text = "Number : \( details?.email ?? "Email")"
        contactEmail.text = "Email : \(details?.number ?? "Number")"
        
    }
}
