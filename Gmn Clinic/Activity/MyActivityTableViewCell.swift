//
//  MyActivityTableViewCell.swift
//  Gmn Clinic
//
//  Created by apple on 09/03/18.
//  Copyright © 2018 Tsysinfo. All rights reserved.
//

import UIKit

class MyActivityTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBOutlet weak var time: UILabel!
    
    @IBOutlet weak var activity: UILabel!
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
