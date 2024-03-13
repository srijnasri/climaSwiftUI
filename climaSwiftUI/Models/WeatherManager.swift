//
//  WeatherManager.swift
//  climaSwiftUI
//
//  Created by Srijnasri Negi on 13/03/24.
//

import Foundation
import Combine

class WeatherManager: ObservableObject {
    
    private let url = "https://api.openweathermap.org/data/2.5/weather?appid=8e3952d4419e7492ce68b4707c645a32&units=metric"
    @Published var weatherModel: WeatherViewModel?
    private var cancellable: Set<AnyCancellable> = []
    
    func fetchData(city: String) {
        let actualUrl = url + "&q=\(city)"
        performUrlRequest(url: actualUrl)
    }
    
    func fetchDataForLocation(lat: Double, lon: Double) {
        let actualUrl = url + "&lat=\(lat)&lon=\(lon)"
        performUrlRequest(url: actualUrl)
    }
    
    func performUrlRequest(url: String) {
        // create url
        
        if let url = URL(string: url) {
            URLSession.shared.dataTaskPublisher(for: url)
                .map{ $0.data }
                .decode(type: WeatherData.self, decoder: JSONDecoder())
                .map { WeatherData -> WeatherViewModel? in
                    WeatherViewModel(conditionId: WeatherData.weather.first?.id ?? 0,
                                     cityName: WeatherData.name,
                                     temperature: WeatherData.main.temp)
                }
                .replaceError(with: nil)
                .receive(on: DispatchQueue.main)
                .assign(to: \.weatherModel, on: self)
                .store(in: &cancellable)
            print($weatherModel)
        }
    }
}
