//
//  ToApplyCell.swift
//  JobTrack
//
//  Created by Connor Alvin on 5/7/18.
//  Copyright © 2018 Connor Alvin. All rights reserved.
//

import UIKit

class ToApplyCell: UITableViewCell {

    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
