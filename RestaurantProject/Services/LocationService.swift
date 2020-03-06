//
//  LocationService.swift
//  RestaurantProject
//
//  Created by Gary Tokman  on 25/2/20.
//  Copyright © 2020 LastBlade. All rights reserved.
//

import Foundation
import CoreLocation

enum Result<T> {
    case success(T)
    case failure(Error)
}

final class LocationService: NSObject {
    var manager : CLLocationManager
    
    init(manager:CLLocationManager = .init()) {
        self.manager = manager
        super.init()
        manager.delegate = self
    }
    
    var newLocation: ((Result<CLLocation>) -> Void)?
    var didChangeStatus: ((Bool) -> Void)?
    
    var status : CLAuthorizationStatus {
        return CLLocationManager.authorizationStatus()
    }
    
    func requestAuthorization() {
        manager.requestWhenInUseAuthorization()
    }
    /*
     The service will attempt to determine location with accuracy according
     to the desiredAccuracy property.
     */
    func getLocation() {
        manager.requestLocation()
    }
}

extension LocationService : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        newLocation?(.failure(error))
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // One way
        if let location = locations.sorted(by: { $0.timestamp > $1.timestamp}).first {
            newLocation?(.success(location))
        }
        
        // Second way
        //        if let location = locations.sorted(by: { (clLoc1, clLoc2) -> Bool in
        //           return clLoc1.timestamp > clLoc2.timestamp
        //        }).first {
        //            newLocation?(.success(location))
        //        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined, .denied, .restricted:
            didChangeStatus?(false)
        default:
            didChangeStatus?(true)
        }
    }
}
