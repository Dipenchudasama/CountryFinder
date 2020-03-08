//
//  CountryDetailTableViewCell.swift
//  TestApp
//
//  Created by DGV on 07/03/20.
//  Copyright © 2020 Dipen. All rights reserved.
//

import UIKit

class CountryDetailTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var descriptionLable: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
