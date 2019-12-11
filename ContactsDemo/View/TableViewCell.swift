//
//  TableViewCell.swift
//  ContactsDemo
//
//  Created by Prithvi Raj on 09/12/19.
//  Copyright © 2019 Prithvi Raj. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet weak var contactName: UILabel!
    @IBOutlet weak var userImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
