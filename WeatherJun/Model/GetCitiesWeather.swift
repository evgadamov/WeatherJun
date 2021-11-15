	//
	//  GetCitiesWeather.swift
	//  WeatherJun
	//
	//  Created by Evgeny Adamov on 26.09.2021.
	//

import Foundation
import CoreLocation

let networkManager = NetworkManager()

func getCitiesWeather(citiesArray: [String], completionHandler: @escaping (String, Weather) -> Void) {
	for city in citiesArray {
		getCoordinate(from: city) { coordinate, cityName, error in
			guard let coordinate = coordinate,
				  let cityName = cityName,
				  error == nil else {
					  return
				  }
			networkManager.fetchData(lat: coordinate.latitude, lon: coordinate.longitude) { weather in
				completionHandler(cityName, weather)
			}
		}
	}
}

func getCoordinate(from name: String, completionHandler: @escaping (CLLocationCoordinate2D?, String?, Error?) -> Void) {
	let geocoder = CLGeocoder()
	
	geocoder.geocodeAddressString(name, in: nil, preferredLocale: Locale(identifier: "ru_Ru")) { placemark, error in
		guard error == nil, let placemark = placemark else { return }
		let coordinate = placemark.first?.location?.coordinate
		let cityName = placemark.first?.locality
		
		completionHandler(coordinate, cityName, error)
	}
}
