//
//  City.swift
//  WeatherApp
//
//  Created by vinay kumar on 14/07/24.
//

import Foundation

struct City: Codable {
    let id: Int
    let name: String
    let country: String
    let sunrise: Date
    let sunset: Date
    
    static let sample = City(id: 1261529, name: "Nellore", country: "IN", sunrise: Date(timeIntervalSince1970: 1720916325), sunset: Date(timeIntervalSince1970: 1720962783))
}
