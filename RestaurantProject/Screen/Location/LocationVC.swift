//
//  LocationVC.swift
//  RestaurantProject
//
//  Created by MacBook Pro  on 25/2/20.
//  Copyright © 2020 LastBlade. All rights reserved.
//

import UIKit

protocol LocationActions : class {
    func didTapAllow()
    
}

class LocationVC: UIViewController {
    
    @IBOutlet weak var locationView : LocationView!
    weak var delegate : LocationActions?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationView?.allowBtnTapped = { [weak self] in
            self?.delegate?.didTapAllow()
        }
        
       
    
    }
    

    
}
