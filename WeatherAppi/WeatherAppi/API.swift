//
//  API.swift
//  WeatherAppi
//
//  Created by Minna on 7.2.2020.
//  Copyright © 2020 Mikko. All rights reserved.
//

private let urlForCurrentWeather = URL(string:
    "https://api.openweathermap.org/data/2.5/weather")!
private let API_KEY = "e72786565emsh681b17e6e82b31dp13c8efjsn25a1cd06b0d4"
private let urlForWeeklyWeather = URL(string:
    "https://api.openweathermap.org/data/2.5/forecast/daily")!

private var decoder: JSONDecoder{
    let decode = JSONDecoder()
    decode.keyDecodingStrategy = .convertFromSnakeCase
    return decode
}

import Foundation
import SwiftUI

class API{
    
    class func fetchCurrentWeather(by city: String, onSuccess: @escaping (Weather) -> Void) {
        let query = ["q": "\(city)", "apiKey": API_KEY, "units": "Metric"]
        
        guard let url = urlForCurrentWeather.withQueries(query) else {
            fatalError()
        }
        URLSession.shared.dataTask(with: url) { (data, res, err) in
            guard let data = data, err == nil else  {
                fatalError(err!.localizedDescription)
            }
            do {
                let weather = try decoder.decode(Weather.self, from: data)
                DispatchQueue.main.async {
                    onSuccess(weather)
                }
            }
            catch {
                fatalError(error.localizedDescription)
            }
        } .resume()
    }
}

extension URL {
    func withQueries(_ queries: [String: String]) -> URL? {
        guard var component = URLComponents(url: self, resolvingAgainstBaseURL: true) else {
            fatalError()
        }
        component.queryItems = queries.map { URLQueryItem(name: $0.key, value:
            $0.value)}
        return component.url
    }
}
