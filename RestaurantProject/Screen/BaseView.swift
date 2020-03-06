//
//  BaseView.swift
//  RestaurantProject
//
//  Created by MacBook Pro  on 25/2/20.
//  Copyright © 2020 LastBlade. All rights reserved.
//

import UIKit

@IBDesignable class BaseView : UIView {
    
    override init(frame: CGRect) {
        super.init(frame :frame)
        self.configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configure()
    }
    
    func configure()
    {
        
    }
}
