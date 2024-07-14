//
//  WeatherForeCaseListView.swift
//  WeatherApp
//
//  Created by vinay kumar on 14/07/24.
//

import SwiftUI

struct WeatherForeCaseListView: View {
    
    @ObservedObject var weatherForeCaseListViewModel: WeatherForeCaseListViewModel
    
    var body: some View {
        
        HStack {
            TextField(text: $weatherForeCaseListViewModel.location) {
                Text("Enter Location")
            }
            .onSubmit {
                weatherForeCaseListViewModel.searchForcastFor(location: weatherForeCaseListViewModel.location)
            }
            .textFieldStyle(.roundedBorder)
            
            Button {
                weatherForeCaseListViewModel.searchForcastFor(location: weatherForeCaseListViewModel.location)
                UIApplication.shared.dismissKeyBoard()
            } label: {
                Image(systemName: "magnifyingglass")
                    .foregroundStyle(.blue)
            }

        }
        .padding(.horizontal, 20)
        
        if let error = weatherForeCaseListViewModel.error {
            Text(error)
                .bold()
                .foregroundStyle(.red)
        }
        
        Picker(selection: $weatherForeCaseListViewModel.tempUnits) {
            ForEach(TempUnits.allCases) { temp in
                Text(temp.units)
           }
        } label: {
            Text("Temp Units")
        }
        .pickerStyle(SegmentedPickerStyle())
        .frame(width: 100)
        .padding(10)
        
        if weatherForeCaseListViewModel.loading {
            ProgressView()
        }
        
        if weatherForeCaseListViewModel.foreCasts.isEmpty {
            Text("No ForeCasts")
            Spacer()
        } else {
            
            if let city = weatherForeCaseListViewModel.city {
                VStack {
                    Text(weatherForeCaseListViewModel.getCityName(city: city))
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.bottom, 8)
                    
                    HStack {
                        Text(weatherForeCaseListViewModel.sunriseAt(city: city))
                        Text(weatherForeCaseListViewModel.sunsetAt(city: city))
                    }
                    .font(.subheadline)
                }
            }
            
            List(weatherForeCaseListViewModel.foreCasts, id: \.dt) { forecast in
                WeatherCardItem(weatherCardItemViewModel: WeatherCardItemViewModel(forecast: forecast, tempUnits: weatherForeCaseListViewModel.tempUnits))
                    .frame(maxWidth: .infinity)

            }
            .listStyle(.plain)
        }
        
        Spacer()
    }
}

#Preview {
    WeatherForeCaseListView(weatherForeCaseListViewModel: WeatherForeCaseListViewModel(foreCastWeatherLoader: PreviewCastWeatherManager()))
}
