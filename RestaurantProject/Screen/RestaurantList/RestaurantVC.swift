//
//  RestaurantVC.swift
//  RestaurantProject
//
//  Created by MacBook Pro  on 25/2/20.
//  Copyright © 2020 LastBlade. All rights reserved.
//

import UIKit
import Moya

class RestaurantVC: UITableViewController {
    
    var viewmodels = [RestaurantListVM]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    
    
}

extension RestaurantVC {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewmodels.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantTableViewCell", for: indexPath) as! RestaurantTableViewCell
        
        let vm = viewmodels[indexPath.row]
        cell.updateView(vm: vm)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vm = viewmodels[indexPath.row]
        
        syncRestaurantDetails(withId: vm.id)
    }
    
    func syncRestaurantDetails(withId id : String) {
        let service = MoyaProvider<YelpService>()
        let decoder = JSONDecoder()
        
        service.request(.details(id: id)) {[weak self] (result) in
            switch result {
            case .success(let response):
                guard self != nil else {
                    return
                }
                
                if let details = try? decoder.decode(Details.self, from: response.data) {
                    guard let detailsVC = self?.storyboard?.instantiateViewController(identifier: "DetailsVC") else {
                        return
                    }
                 
                    self?.navigationController?.pushViewController(detailsVC, animated: true)
                    
                    let detailsVM = DetailVM(detail: details)
                    (detailsVC as? DetailsVC)?.viewModel = detailsVM
                 //   (self?.navigationController?.topViewController as! DetailsVC).viewModel = detailsVM
                 }
                
            case .failure(let error):
                print("\(error)")
                assertionFailure()
            }
        }
        
    }
    
}
