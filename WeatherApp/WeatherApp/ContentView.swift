//
//  ContentView.swift
//  WeatherApp
//
//  Created by vinay kumar on 14/07/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            WeatherForeCaseListView(weatherForeCaseListViewModel: WeatherForeCaseListViewModel(foreCastWeatherLoader: ForeCastWeatherManager()))
                .navigationTitle("Weather Finder")
            
            Spacer()
        }
    }
}

#Preview {
    ContentView()
}
