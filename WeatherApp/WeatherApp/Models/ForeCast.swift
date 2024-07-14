//
//  ForeCast.swift
//  WeatherApp
//
//  Created by vinay kumar on 14/07/24.
//

import Foundation

struct ForeCast: Codable {
    
    struct Main: Codable {
        let temp: Double
        let tempMin: Double
        let tempMax: Double
        let humidity: Int
        
        static let sample = Main(temp: 300.29, tempMin: 300.29, tempMax: 300.29, humidity: 73)
    }
    
    let dt: Date
    let main: Main
    let weather: [Weather]
    
    static let sample = ForeCast(dt: Date(timeIntervalSince1970: 1720947600), main: Main.sample, weather: [Weather.sample])
}
