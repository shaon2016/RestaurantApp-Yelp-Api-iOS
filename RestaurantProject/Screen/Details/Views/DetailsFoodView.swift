//
//  DetailsFoodView.swift
//  RestaurantProject
//
//  Created by MacBook Pro  on 25/2/20.
//  Copyright © 2020 LastBlade. All rights reserved.
//

import UIKit
import MapKit

@IBDesignable class DetailsFoodView : BaseView {
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var pageController: UIPageControl!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var hoursLabel: UILabel!
    @IBOutlet weak var locLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    @IBOutlet weak var mapView: MKMapView!
   
    @IBAction func handleControl(_ sender: Any) {
    }
}
