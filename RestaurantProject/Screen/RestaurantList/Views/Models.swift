//
//  Models.swift
//  RestaurantProject
//
//  Created by Ashiq  on 27/2/20.
//  Copyright © 2020 LastBlade. All rights reserved.
//

import Foundation
import CoreLocation

public struct Root : Codable {
    let businesses : [Business]
    
}

struct Business : Codable {
    let id : String
    let name : String
    let imageUrl : URL
    let distance : Double
    
    enum CodingKeys: String, CodingKey {
        case id, name, distance
        case imageUrl = "image_url"
    }
    
}

struct RestaurantListVM {
    let id : String
    let name : String
    let imageUrl : URL
    let distance : Double
    
    static var numberFormatter : NumberFormatter {
        let ns = NumberFormatter()
        ns.numberStyle = .decimal
        ns.minimumFractionDigits = 2
        ns.maximumFractionDigits = 2
        return ns
    }
    
    var formattedDistance : String?  {
        return RestaurantListVM.numberFormatter.string(from: distance as NSNumber)
    }
    
    init(business : Business) {
        id = business.id
        name = business.name
        imageUrl = business.imageUrl
        distance = business.distance / 1609.344
    }
}

struct Details: Decodable {
    let price : String
    let phone : String
    let isClosed: Bool
    let rating: Double
    let name: String
    let photos: [URL]
    let coordinates: CLLocationCoordinate2D
    
    enum CodingKeys: String, CodingKey {
        case price, phone
        case isClosed = "is_closed"
        case rating, name, photos
        case coordinates
    }
}

extension CLLocationCoordinate2D : Decodable {
    
    enum CodingKeys:  String, CodingKey {
        case latitude
        case longitude
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let latitude = try container.decode(Double.self, forKey: .latitude)
        let longitude = try container.decode(Double.self, forKey: .longitude)

        self.init(latitude: latitude, longitude: longitude)

    }
}

struct DetailVM {
    let price : String
    let phone : String
    let isOpen: String
    let rating: String
    let name: String
    let photos: [URL]
    let cordinates: CLLocationCoordinate2D
    
    init(detail : Details) {
        price = detail.price
        phone = detail.phone
        isOpen = detail.isClosed ? "Closed" : "Open"
        rating = "\(detail.rating) /  5.0"
        name = detail.name
        photos = detail.photos
        cordinates = detail.coordinates
    }
}
