//
//  AttachedStudentsTableViewCell.swift
//  College
//
//  Created by Rajat Tyagi on 06/07/20.
//  Copyright © 2020 Rajat Tyagi. All rights reserved.
//

import UIKit

class AttachedStudentsTableViewCell: UITableViewCell {

    @IBOutlet weak var studentNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
