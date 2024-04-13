//
//  ContentView.swift
//  climaSwiftUI
//
//  Created by Srijnasri Negi on 13/03/24.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var weatherManager = WeatherManager()
    @State var inputCityName: String
    @State var isSearchOn: Bool = false
    
    var body: some View {
        let weatherModel = weatherManager.weatherModel
        
        NavigationStack {
            Spacer()
            Image(systemName: weatherModel?.conditionName ?? "")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text(String(format: "Hello, Todays the temp in %1$@ is %2$@ !",
                        weatherModel?.cityName ?? "",
                        weatherModel?.temperatureString ?? ""))
            Spacer()
        }
        .searchable(text: $inputCityName)
        .padding()
        .onAppear {
            weatherManager.fetchData(city: inputCityName)
        }
        .onChange(of: inputCityName) {
            if !inputCityName.isEmpty {
                weatherManager.fetchData(city: inputCityName)
            } else {
            }
        }
    }
}

#Preview {
    ContentView(inputCityName: "delhi")
}
