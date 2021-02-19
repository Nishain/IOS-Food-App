//
//  CustomTableViewCell.swift
//  Food App
//
//  Created by Nishain on 2/11/21.
//  Copyright © 2021 Nishain. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var foodPicture: UIImageView!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var foodTitle: UILabel!
    @IBOutlet weak var ingredients: UILabel!
    @IBOutlet weak var distance: UILabel!
    @IBOutlet weak var expandBtn: UIButton!
    @IBOutlet weak var mainView: UIStackView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
