//
//  LocationView.swift
//  RestaurantProject
//
//  Created by MacBook Pro  on 25/2/20.
//  Copyright © 2020 LastBlade. All rights reserved.
//

import UIKit

@IBDesignable class LocationView : BaseView {
    
    @IBOutlet weak var allowBtn: UIButton!
    @IBOutlet weak var denyBtn: UIButton!
    
    var allowBtnTapped: (()->Void)?
    var noAnotherTimeBtnTapped: (()->Void)?
    
    @IBAction func noAnotherTime(_ sender: Any) {
        noAnotherTimeBtnTapped?()
    }
    @IBAction func allow(_ sender: Any) {
        allowBtnTapped?()
    }
}
