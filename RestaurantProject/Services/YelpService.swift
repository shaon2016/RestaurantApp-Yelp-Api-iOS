//
//  YelpService.swift
//  RestaurantProject
//
//  Created by MacBook Pro  on 27/2/20.
//  Copyright © 2020 LastBlade. All rights reserved.
//

import Foundation
import Moya

private let apiKey = "JswbGRv-K2DcqjP_64zIieDH6dB6UBBd4V7HxIiZzC4OWdjb9nQk2iQ_fBe8T3NORQuS1qNmmo-TnmEqI30DFiymQnfwZ0zMurHhl0TFZFtE3qkZlPsSZRwuw1JXXnYx"


enum YelpService {
    case businesses(lat : Double, lon : Double)
    case details(id: String)
}

extension YelpService : TargetType {
    
    var baseURL: URL {
        return URL(string: "https://api.yelp.com/v3/businesses/")!
    }
    
    var path: String {
        switch self {
        case .businesses:
            return "search"
        case let .details(id):
            return id
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .businesses:
            return .get
        case .details:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case let .businesses(lat, lon):
            return .requestParameters(parameters: [
                "latitude" : lat,
                "longitude" : lon,
                "limit" : 25
            ], encoding: URLEncoding.default)
        case let .details(id): return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return ["Authorization": "Bearer \(apiKey)"]
    }
}
