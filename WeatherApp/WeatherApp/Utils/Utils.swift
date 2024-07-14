//
//  Utils.swift
//  WeatherApp
//
//  Created by vinay kumar on 14/07/24.
//

import Foundation

class Utils {
    static func getHumanReadableDateTime(from date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy 'at' h:mm a"
        return dateFormatter.string(from: date)
    }
    
    static func getHumanReadableTime(from date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        return dateFormatter.string(from: date)
    }
}
