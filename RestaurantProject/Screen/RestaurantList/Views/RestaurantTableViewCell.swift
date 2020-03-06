//
//  RestaurantTableViewCell.swift
//  RestaurantProject
//
//  Created by MacBook Pro  on 25/2/20.
//  Copyright © 2020 LastBlade. All rights reserved.
//

import UIKit
import AlamofireImage

class RestaurantTableViewCell: UITableViewCell {

    @IBOutlet weak var restaurantIV: UIImageView!
    @IBOutlet weak var makerIV: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var locLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateView(vm : RestaurantListVM) {
        nameLabel.text = vm.name
        locLabel.text = vm.formattedDistance
        restaurantIV.af_setImage(withURL: vm.imageUrl,completion: nil)
    }

}
