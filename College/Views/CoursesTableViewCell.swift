//
//  CoursesTableViewCell.swift
//  College
//
//  Created by Rajat Tyagi on 05/07/20.
//  Copyright © 2020 Rajat Tyagi. All rights reserved.
//

import UIKit

class CoursesTableViewCell: UITableViewCell {
    @IBOutlet weak var courseNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
