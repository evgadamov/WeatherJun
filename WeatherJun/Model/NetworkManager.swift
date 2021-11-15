//
//  NetworkManager.swift
//  WeatherJun
//
//  Created by Evgeny Adamov on 26.09.2021.
//

import Foundation

struct NetworkManager {
	private let baseURLString = "https://api.weather.yandex.ru/v2/forecast"
	
	func fetchData(lat: Double, lon: Double, completionHandler: @escaping (Weather) -> Void) {
		let latQuery = URLQueryItem(name: "lat", value: String(lat))
		let lonQuery = URLQueryItem(name: "lon", value: String(lon))
		let limitQuery = URLQueryItem(name: "limit", value: "1")
		let queryItems = [latQuery, lonQuery, limitQuery]
		var url = URLComponents(string: baseURLString)
		url?.queryItems = queryItems
		
		guard let url = url?.url else { return }
		
		print(url)
		
		var request = URLRequest(url: url)
		request.addValue("9849d50f-aec5-47f0-b32e-90c55cc6a907", forHTTPHeaderField: "X-Yandex-API-Key")
		
		let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
			guard error == nil else {
				print("Error в request!")
				return
			}
			
			if let data = data,
			   let weatherData = self.parseJSON(from: data) {
				completionHandler(weatherData)
			}
		}
		task.resume()
	}
	
	// Декодируем полученные данные в JSON
	
	private func parseJSON(from data: Data) -> Weather? {
		let decoder = JSONDecoder()
		
		do {
			let weatherData = try decoder.decode(WeatherData.self, from: data)
			let weather = Weather(with: weatherData)
			return weather
		} catch let error as NSError {
			print(error.localizedDescription)
			
		}
		return nil
	}
}
