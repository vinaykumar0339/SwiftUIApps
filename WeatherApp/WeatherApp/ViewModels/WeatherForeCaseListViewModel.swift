//
//  WeatherForeCaseListViewModel.swift
//  WeatherApp
//
//  Created by vinay kumar on 14/07/24.
//

import CoreLocation
import Foundation

class WeatherForeCaseListViewModel: ObservableObject {
    @Published var foreCasts: [ForeCast] = []
    @Published var city: City?
    @Published var tempUnits: TempUnits = .celsius
    @Published var error: String?
    @Published var loading: Bool = false
    @Published var location: String = ""
    
    let foreCastWeatherLoader: ForeCastWeatherLoader
    
    init(foreCastWeatherLoader: ForeCastWeatherLoader) {
        self.foreCastWeatherLoader = foreCastWeatherLoader
    }
    
    func sunriseAt(city: City) -> String {
        return "Sunrise At: \(Utils.getHumanReadableTime(from: city.sunrise))"
    }
    
    func sunsetAt(city: City) -> String {
        return "Sunset At: \(Utils.getHumanReadableTime(from: city.sunset))"
    }
    
    func getCityName(city: City) -> String {
        return "\(city.name), \(city.country)"
    }
    
    func loadFiveDaysForecaseFor3H(latitude: Double, longitude: Double) {
        self.loading = true
        foreCastWeatherLoader.loadFiveDaysForecaseFor3H(lat: latitude, lon: longitude) { [weak self] foreCastApiResponse, error in
            guard let foreCastApiResponse = foreCastApiResponse else {
                self?.error = error?.localizedDescription
                self?.loading = false
                return
            }
            
            DispatchQueue.main.async {
                self?.foreCasts = foreCastApiResponse.list;
                self?.city = foreCastApiResponse.city
                self?.error = nil
                self?.loading = false
            }
        }
    }
    
    func searchForcastFor(location: String) {
        let geocoder = CLGeocoder()
        self.loading = true
        geocoder.geocodeAddressString(location) { [weak self] (placemarks, error) in
            if let error = error as? CLError {
                switch error.code {
                case .locationUnknown, .geocodeFoundNoResult, .geocodeFoundPartialResult:
                    self?.error = "Unable to determine location from given text"
                case .network:
                    self?.error = "You donot appear to have network connection. please check."
                default:
                    self?.error = error.localizedDescription
                }
                self?.loading = false
                print("Geocoding error: \(error.localizedDescription)")
                return
            }
            
            guard let placemark = placemarks?.first else {
                self?.error = "No Place found for the location \(location)"
                self?.loading = false
                print("No placemark found for \(location)")
                return
            }
            
            // Access the location coordinates (latitude and longitude)
            let coordinates = placemark.location?.coordinate
            if let latitude = coordinates?.latitude, let longitude = coordinates?.longitude {
                print("Location: \(location)")
                print("Latitude: \(latitude)")
                print("Longitude: \(longitude)")
                
                // Call a method to fetch forecast using latitude and longitude
                self?.loadFiveDaysForecaseFor3H(latitude: latitude, longitude: longitude)
            } else {
                self?.error = "Failed to retrieve coordinates for \(location)"
                self?.loading = false
                print("Failed to retrieve coordinates for \(location)")
            }
        }
    }
}
