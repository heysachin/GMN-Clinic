//
//  DietTableViewCell.swift
//  Gmn Clinic
//
//  Created by apple on 17/02/18.
//  Copyright © 2018 Tsysinfo. All rights reserved.
//

import UIKit

class DietTableViewCell: UITableViewCell {

    @IBOutlet weak var diet: UILabel!
    @IBOutlet weak var time: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
