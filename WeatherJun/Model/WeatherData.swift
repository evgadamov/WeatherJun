//
//  WeatherData.swift
//  WeatherJun
//
//  Created by Evgeny Adamov on 26.09.2021.
//

import Foundation

struct WeatherData: Decodable {
	var fact: Fact
}

struct Fact: Decodable {
	var temp: Double
	var icon: String
	var condition: String
}
