//
//  CurrentWeatherViewModel.swift
//  WeatherAppi
//
//  Created by Minna on 7.2.2020.
//  Copyright © 2020 Mikko. All rights reserved.
//

import SwiftUI
import Combine

final class CurrentWeatherViewModel: ObservableObject {
    @Published var current: Weather?
    
    init() {
        self.fetch()
    }
}

extension CurrentWeatherViewModel {
    func fetch(_ city: String = "Lappeenranta"){
        API.fetchCurrentWeather(by: city) {
            self.current = $0
        }
    }
}
