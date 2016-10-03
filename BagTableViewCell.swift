//
//  BagTableViewCell.swift
//  BagTracker
//
//  Created by 韩猷 on 10/2/16.
//  Copyright © 2016 Apple Inc. All rights reserved.
//

import UIKit

class BagTableViewCell: UITableViewCell {
    
    // MARK: Properties
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var ratingControl: RatingControl!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
