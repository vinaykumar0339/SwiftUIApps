//
//  ForeCastWeatherManager.swift
//  WeatherApp
//
//  Created by vinay kumar on 14/07/24.
//

import Foundation

protocol ForeCastWeatherLoader {
    func loadFiveDaysForecaseFor3H(lat: Double, lon: Double, completion: @escaping (ForeCastApiResponse?, NetworkManager.ApiError?) -> Void)
}

class ForeCastWeatherManager: ForeCastWeatherLoader {
    func loadFiveDaysForecaseFor3H(lat: Double, lon: Double, completion: @escaping (ForeCastApiResponse?, NetworkManager.ApiError?) -> Void) {
        NetworkManager.shared.get(urlString: "https://api.openweathermap.org/data/2.5/forecast?lat=\(lat)&lon=\(lon)&appid=\(NetworkManager.APIKEY)", model: ForeCastApiResponse.self, dateDecodingStrategy: .secondsSince1970) { result in
            switch result {
            case .success(let success):
                completion(success, nil)
            case .failure(let failure):
                print("error loading forecast \(failure.localizedDescription)")
                completion(nil, .failure(string: "error loading forecast \(failure.localizedDescription)"))
            }
        }
    }
}

class PreviewCastWeatherManager: ForeCastWeatherLoader {
    func loadFiveDaysForecaseFor3H(lat: Double, lon: Double, completion: @escaping (ForeCastApiResponse?, NetworkManager.ApiError?) -> Void) {
        completion(ForeCastApiResponse(list: [ForeCast.sample, ForeCast.sample, ForeCast.sample], city: City.sample) ,nil)
    }
}
