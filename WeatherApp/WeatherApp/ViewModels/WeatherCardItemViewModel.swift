//
//  WeatherCardItemViewModel.swift
//  WeatherApp
//
//  Created by vinay kumar on 14/07/24.
//

import Foundation

enum TempUnits: String, CaseIterable, Identifiable {
    var id: Self { self }
    
    case kelvin
    case celsius
    case fahrenheit
    
    var units: String {
        switch self {
        case .kelvin:
            return "°K"
        case .celsius:
            return "°C"
        case .fahrenheit:
            return "°F"
        }
    }
    
    private func kelvinToCelsius(kelvin: Double) -> Double {
        return kelvin - 273.15
    }
    
    // Function to convert Kelvin to Fahrenheit
    private func kelvinToFahrenheit(kelvin: Double) -> Double {
        let celsius = kelvinToCelsius(kelvin: kelvin)
        return celsius * 9/5 + 32
    }
    
    func getTempWithDegree(kelvinTemp: Double) -> String {
        switch self {
        case .kelvin:
            return "\(String(format: "%.2f", kelvinTemp))\(units)"
        case .celsius:
            return "\(String(format: "%.2f", kelvinToCelsius(kelvin: kelvinTemp)))\(units)"
        case .fahrenheit:
            return "\(String(format: "%.2f", kelvinToFahrenheit(kelvin: kelvinTemp)))\(units)"
        }
    }
}

class WeatherCardItemViewModel: ObservableObject {
    var forecast: ForeCast
    var tempUnits: TempUnits
    
    init(forecast: ForeCast, tempUnits: TempUnits = .kelvin) {
        self.forecast = forecast
        self.tempUnits = tempUnits
    }
    
    var date: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy 'at' h:mm a"
        return dateFormatter.string(from: forecast.dt)
    }
    
    var weatherIconUrl: URL? {
        return URL(string: "https://openweathermap.org/img/wn/\(forecast.weather[0].icon).png")
    }
    
    var temp: String {
        return tempUnits.getTempWithDegree(kelvinTemp: forecast.main.temp)
    }
    
    var description: String {
        return forecast.weather[0].description.capitalized
    }
    
    var highTemp: String {
        return "High: \(tempUnits.getTempWithDegree(kelvinTemp: forecast.main.tempMax))"
    }
    
    var lowTemp: String {
        return "Low: \(tempUnits.getTempWithDegree(kelvinTemp: forecast.main.tempMin))"
    }
    
    var humidity: String {
        return "Humidity: \(forecast.main.humidity)%"
    }

}
