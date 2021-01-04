//
//  NetworkingConstants.swift
//  KrasnayaPolyanaTest
//
//  Created by Виктор Кобыхно on 1/4/21.
//

import Foundation

protocol WeatherNetworkingProtocol {
    func getWeatherData(city: String, completion: @escaping ([WeatherList]?) -> Void)
}

class WeatherNetworking: WeatherNetworkingProtocol {
    
    private var apiUrl: String = "api.openweathermap.org"
    private var weatherApiKey: String = "2e441faa7dee387b6367edadc41904ae"
    
    private func absoluteUrlBuilder(_ city: String) -> URL {
        var urlComponents: URL? {
            var component = URLComponents()
            component.scheme = "https"
            component.host = self.apiUrl
            component.path = "/data/2.5/forecast"
            var queryParams = [URLQueryItem]()
            queryParams.append(URLQueryItem(name: "q", value: city))
            queryParams.append(URLQueryItem(name: "appid", value: self.weatherApiKey))
            queryParams.append(URLQueryItem(name: "units", value: "metric"))
            queryParams.append(URLQueryItem(name: "lang", value: "RU"))
            component.queryItems = queryParams
            return component.url
        }
        return urlComponents!.absoluteURL
    }
    
    func getWeatherData(city: String, completion: @escaping ([WeatherList]?) -> Void) {
        var request = URLRequest(url: self.absoluteUrlBuilder(city))
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let data = data {
                let weatherData = try! JSONDecoder().decode(WeatherData.self, from: data)
                completion(weatherData.list)
            } else {
                completion(nil)
            }
        }.resume()
    }
    
}
