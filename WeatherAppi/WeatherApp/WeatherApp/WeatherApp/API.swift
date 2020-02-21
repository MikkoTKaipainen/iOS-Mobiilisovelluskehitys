//
//  API.swift
//  WeatherApp
//
//  Created by Mikko Kaipainen on 21/02/2020.
//  Copyright © 2020 Mikko Kaipainen. All rights reserved.
//


private let urlForCurrentWeather = URL(string:
    "https://api.openweathermap.org/data/2.5/weather")!
private let API_KEY = "47b689525963994e4fa5638a2a416d1b"

private var decoder: JSONDecoder{
    let decode = JSONDecoder()
    decode.keyDecodingStrategy = .convertFromSnakeCase
    return decode
}

import SwiftUI

class API {
    
    class func fetchCurrentWeather(by city: String, onSuccess:  @escaping (Weather) -> Void){
        let query = ["q": "\(city)", "appid": API_KEY, "units": "Metric"]
            
              guard let url = urlForCurrentWeather.withQueries(query)  else {
              
                  fatalError()
              }
                print(url)
              URLSession.shared.dataTask(with: url) { (data, res, err) in
                  guard let data = data, err == nil else {
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
              }.resume()
          }
      }

extension URL {
    func withQueries(_ queries: [String: String]) -> URL? {
        guard var component = URLComponents(url: self, resolvingAgainstBaseURL: true) else {
            fatalError()
        }
        component.queryItems = queries.map { URLQueryItem(name: $0.key, value: $0.value)}
        return component.url
    }
}

