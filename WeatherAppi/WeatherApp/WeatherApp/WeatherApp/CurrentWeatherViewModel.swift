//
//  CurrentWeatherViewModel.swift
//  WeatherApp
//
//  Created by Mikko Kaipainen on 21/02/2020.
//  Copyright © 2020 Mikko Kaipainen. All rights reserved.
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
    func fetch(_ city: String = "lappeenranta") {
        API.fetchCurrentWeather(by: city) {
            self.current = $0
        }
    }
}

