//
//  DetailsVC.swift
//  RestaurantProject
//
//  Created by MacBook Pro  on 25/2/20.
//  Copyright © 2020 LastBlade. All rights reserved.
//

import UIKit
import AlamofireImage
import CoreLocation
import MapKit

class DetailsVC: UIViewController {
    
    @IBOutlet weak var detailsFoodView : DetailsFoodView?
    var viewModel : DetailVM?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailsFoodView?.collectionView.register(DetailsCollectionViewCell.self, forCellWithReuseIdentifier: "ImageCell")
        detailsFoodView?.collectionView.dataSource = self
        detailsFoodView?.collectionView.delegate = self
        
        updateView()
    }
    
    func updateView() {
        if let viewModel = viewModel {
            detailsFoodView?.priceLabel.text = viewModel.price
            detailsFoodView?.ratingLabel.text = viewModel.rating
            detailsFoodView?.hoursLabel.text = viewModel.isOpen
            detailsFoodView?.locLabel.text = viewModel.phone
            
            detailsFoodView?.collectionView.reloadData()
            centerMap(for: viewModel.cordinates)
            
            title = viewModel.name
            
        }
        
        
    }
    
    func centerMap(for coordinate : CLLocationCoordinate2D) {
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 100, longitudinalMeters: 100)
        
        let annoation = MKPointAnnotation()
        annoation.coordinate = coordinate
        detailsFoodView?.mapView.addAnnotation(annoation)
        detailsFoodView?.mapView.setRegion(region, animated: true)
        
    }
    
}

extension DetailsVC :UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel?.photos.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! DetailsCollectionViewCell
        if let url = viewModel?.photos[indexPath.row] {
            cell.imageView.af_setImage(withURL: url)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        detailsFoodView?.pageController.currentPage = indexPath.item
    }
}
