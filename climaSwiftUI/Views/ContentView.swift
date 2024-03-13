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
    
    var body: some View {
        let weatherModel = weatherManager.weatherModel
        
        VStack {
            TextField("Enter city name", text: $inputCityName)
                .padding(10)
                .background(.thinMaterial)
                .border(.quaternary)
                .padding(EdgeInsets(top: 50, leading: 10, bottom: 10, trailing: 10))
                .disableAutocorrection(true)
                .onSubmit {
                    weatherManager.fetchData(city: inputCityName)
                }
            Spacer()
            Image(systemName: weatherModel?.conditionName ?? "")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text(String(format: "Hello, Todays the temp in %1$@ is %2$@ !",
                        weatherModel?.cityName ?? "",
                        weatherModel?.temperatureString ?? ""))
            Spacer()
        }
        .padding()
        .onAppear {
            weatherManager.fetchData(city: inputCityName)
        }
    }
}

#Preview {
    ContentView(inputCityName: "delhi")
}
