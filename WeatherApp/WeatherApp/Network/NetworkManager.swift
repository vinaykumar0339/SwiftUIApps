//
//  NetworkManager.swift
//  WeatherApp
//
//  Created by vinay kumar on 14/07/24.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    
    static let APIKEY = "YOUR_API_KEY"
    
    enum ApiError: Error {
        case failure(string: String)
    }
    
    private init() {}
    
    func get<T: Decodable>(urlString: String, 
                           model: T.Type,
                           dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .millisecondsSince1970,
                           keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .convertFromSnakeCase,
                           completion: @escaping (Result<T, ApiError>) -> Void)
    {
        
        guard let url = URL(string: urlString) else {
            completion(.failure(.failure(string: "Error: Invalid Url")))
            return
        }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, respoonse, error in
            if let error = error {
                completion(.failure(.failure(string: "Error: \(error.localizedDescription)")))
                return
            }
            
            guard let data = data else {
                completion(.failure(.failure(string: "Error: Data is corrupted.")))
                return
            }
            
            let jsonDecoder = JSONDecoder()
            jsonDecoder.dateDecodingStrategy = dateDecodingStrategy
            jsonDecoder.keyDecodingStrategy = keyDecodingStrategy
            do {
                let dataModel = try jsonDecoder.decode(model, from: data)
                completion(.success(dataModel))
            } catch {
                completion(.failure(.failure(string: "Error: \(error.localizedDescription)")))
            }
        }.resume()
        
    }
}
