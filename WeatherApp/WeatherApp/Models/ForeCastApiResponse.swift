//
//  ForeCastApiResponse.swift
//  WeatherApp
//
//  Created by vinay kumar on 14/07/24.
//

import Foundation

struct ForeCastApiResponse: Codable {
    let list: [ForeCast]
    let city: City
}
