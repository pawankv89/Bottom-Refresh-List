//
//  ContactAddressBookCell.swift
//  CareApp
//
//  Created by Pawan kumar on 01/06/18.
//  Copyright © 2018 Pawan Kumar. All rights reserved.
//

import UIKit

class ContactAddressBookCell: UITableViewCell {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
