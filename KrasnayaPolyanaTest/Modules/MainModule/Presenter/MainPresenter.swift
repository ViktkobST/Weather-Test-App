//
//  MainPresenter.swift
//  KrasnayaPolyanaTest
//
//  Created by Виктор Кобыхно on 1/4/21.
//

import Foundation

protocol MainPresenterProtocol: class {
    var weatherData: [WeatherList]? { get set }
    init(view: MainViewProtocol, networkingService: WeatherNetworkingProtocol)
    func getWeatherData(_ city: String)
}

class MainPresenter: MainPresenterProtocol {
    
    weak var view: MainViewProtocol?
    let networkingService: WeatherNetworkingProtocol
    var weatherData: [WeatherList]?
    
    required init(view: MainViewProtocol, networkingService: WeatherNetworkingProtocol) {
        self.view = view
        self.networkingService = networkingService
        self.getWeatherData("Красная поляна")
    }
    
    func getWeatherData(_ city: String) {
        networkingService.getWeatherData(city: city) { result in
            guard let weather = result else { return }
            DispatchQueue.main.async {
                self.weatherData = weather
                self.view?.updateData()
            }
        }
    }
    
}
