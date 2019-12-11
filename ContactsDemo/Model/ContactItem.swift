//
//  ContactItem.swift
//  ContactsDemo
//
//  Created by Prithvi Raj on 10/12/19.
//  Copyright © 2019 Prithvi Raj. All rights reserved.
//

import Foundation

struct ContactItem {
    var name: String
    var email: String
    var number: String
    
    init(name: String, email: String ,number: String) {
        self.name = name
        self.number = number
        self.email = email
    }
}
