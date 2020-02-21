//
//  ContentView.swift
//  WeatherApp
//
//  Created by Mikko Kaipainen on 21/02/2020.
//  Copyright © 2020 Mikko Kaipainen. All rights reserved.
//


import SwiftUI

struct ContentView: View {
    
    @State private var selected = 0
    @ObservedObject var weather = CurrentWeatherViewModel()
    @State var city: String = ""
    
    var body: some View {
        
        VStack {
            TextField("Search", text: $city){
                self.weather.fetch(self.city)
            }.padding(.horizontal)
            
            Text("\(weather.current?.name ?? "Unknown")")
                .font(.title)
                .bold()
                .padding(.horizontal)
            
            
            
            HStack(alignment: .center, spacing: 20) {
                GeometryReader{ gr in
                    CurrentWeather(weather: self.weather.current, height: self.selected == 0 ? gr.size.height:
                        gr.size.height * 0.50) .animation(.easeInOut(duration: 0.5))
                    
                }
            }
        }
    }
}

extension Double {
    var  round: Int {
        return Int(self)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
