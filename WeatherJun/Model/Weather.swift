//
//  Weather.swift
//  WeatherJun
//
//  Created by Evgeny Adamov on 26.09.2021.
//

import Foundation

struct Weather {
	var cityName: String = "Название"
	private var temp: Double = 0.0
	var tempStr: String {
		return String(format: "%.0f", self.temp)
	}
	var icon: String = ""
	private var condition: String = ""
	
	var conditionRus: String {
		switch condition {
			case "clear": 					return "ясно"
			case "partly-cloudy": 			return "малооблачно"
			case "cloudy": 					return "облачно с прояснениями"
			case "overcast": 				return "пасмурно"
			case "drizzle": 				return "морось"
			case "light-rain": 				return "небольшой дождь"
			case "rain": 					return "дождь"
			case "moderate-rain": 			return "умеренно сильный дождь"
			case "heavy-rain":				return "сильный дождь"
			case "continuous-heavy-rain":	return "длительный сильный дождь"
			case "showers": 				return "ливень"
			case "wet-snow":				return "дождь со снегом"
			case "light-snow":				return "небольшой снег"
			case "snow":					return "снег"
			case "snow-showers":			return "снегопад"
			case "hail": 					return "град"
			case "thunderstorm":			return "гроза"
			case "thunderstorm-with-rain":	return "дождь с грозой"
			case "thunderstorm-with-hail":	return "гроза с градом"
			default: 						return "нет данных"
		}
	}
	
	init?(with weatherData: WeatherData) {
		self.temp = weatherData.fact.temp
		self.icon = weatherData.fact.icon
		self.condition = weatherData.fact.condition
	}
	
	init() {
		
	}
	
}
