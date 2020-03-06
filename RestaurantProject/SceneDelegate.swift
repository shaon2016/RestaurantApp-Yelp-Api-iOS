//
//  SceneDelegate.swift
//  RestaurantProject
//
//  Created by MacBook Pro  on 12/2/20.
//  Copyright © 2020 LastBlade. All rights reserved.
//

import UIKit
import Moya
import CoreLocation

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    var locationService = LocationService()
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        
        
        
        locationService.didChangeStatus = { [weak self] success in
            if success {
                self?.locationService.getLocation()
            }
        }
        
        locationService.newLocation = { [weak self] success in
            switch success {
            case .success(let location):
                self?.loadBusinesses(with: location.coordinate)
            case .failure(let error):
                assertionFailure("Error getting the users location \(error)")
            }
        }
        
        switch locationService.status {
        case .notDetermined, .denied, .restricted:
            let locationVC = storyboard.instantiateViewController(identifier: "LocationVC") as? LocationVC
            //locationVC?.locationService = locationService
            locationVC?.delegate = self
            window?.rootViewController = locationVC
        default:
            let restaurantNavVC = storyboard.instantiateViewController(identifier: "RestautantNavigationController") as? UINavigationController
            window?.rootViewController = restaurantNavVC
            
//            let cordinator = CLLocationCoordinate2D(latitude:42.361145,longitude:-71.057083)
//            loadBusinesses(with: cordinator)
            
            locationService.getLocation()
        }
        
        window?.makeKeyAndVisible()
        
    }
    
    func loadBusinesses(with cordinate : CLLocationCoordinate2D) {
        let decoder = JSONDecoder()
        let service = MoyaProvider<YelpService>()
        //cordinate.latitude, //cordinate.longitude
        service.request(.businesses(lat:cordinate.latitude, lon: cordinate.longitude)) { [weak self] (result) in
            guard let strongSelf = self else {
                return
            }
            switch result {
            case .success(let response) :
                
                
                let root = try? decoder.decode(Root.self, from: response.data)
                let vm = root?.businesses.compactMap(RestaurantListVM.init)
                    .sorted(by: {$0.distance < $1.distance})
                if let  nav = strongSelf.window?.rootViewController as? UINavigationController,
                    let restaurantListVC = nav.topViewController as? RestaurantVC {
                    restaurantListVC.viewmodels = vm ?? []
                } else if let restaurantNavVC = strongSelf.storyboard.instantiateViewController(identifier: "RestautantNavigationController") as? UINavigationController {
                    strongSelf.window?.rootViewController?.present(restaurantNavVC, animated: true)
                    (restaurantNavVC.topViewController as? RestaurantVC)?.viewmodels = vm ?? []
                }
            case .failure(let error) :
                print(error)
            }
        }
        
        
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
    
    
}

extension SceneDelegate : LocationActions {
    func didTapAllow() {
        locationService.requestAuthorization()
    }
}
