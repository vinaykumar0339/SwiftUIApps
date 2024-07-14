//
//  Weather.swift
//  WeatherApp
//
//  Created by vinay kumar on 14/07/24.
//

import Foundation

struct Weather: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
    
    static let sample = Weather(id: 500, main: "Rain", description: "light rain", icon: "10d")
}
