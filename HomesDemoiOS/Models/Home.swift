//
//  HomeModel.swift
//  HomesDemoiOS
//
//  Created by Parth Anand on 16/01/25.
//

import Foundation
import MapKit

struct Welcome: Codable {
    let homes: [Home]
}

struct Home: Codable, Identifiable {
    let id, price, area, numBedrooms: Int
    let numBathrooms: Int
    let city: String
    let state: String
    let latitude, longitude: Double
    let imageURL1, imageURL2: String

    enum CodingKeys: String, CodingKey {
        case id, price, area
        case numBedrooms = "num_bedrooms"
        case numBathrooms = "num_bathrooms"
        case city, state, latitude, longitude
        case imageURL1 = "image_url_1"
        case imageURL2 = "image_url_2"
    }
    
    var coordinates: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
