//
//  MyFoodTableViewCell.swift
//  Gmn Clinic
//
//  Created by apple on 09/03/18.
//  Copyright © 2018 Tsysinfo. All rights reserved.
//

import UIKit

class MyFoodTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBOutlet weak var food: UILabel!
    @IBOutlet weak var amount: UILabel!
    @IBOutlet weak var unit: UILabel!
    @IBOutlet weak var calorie: UILabel!
    @IBOutlet weak var carbs: UILabel!
    @IBOutlet weak var protein: UILabel!
    @IBOutlet weak var fat: UILabel!
    
    
    @IBOutlet weak var time: UILabel!
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
