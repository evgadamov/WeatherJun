//
//  WeatherCell.swift
//  WeatherJun
//
//  Created by Evgeny Adamov on 26.09.2021.
//

import UIKit

class WeatherCell: UITableViewCell {
	@IBOutlet weak var nameCityLabel: UILabel!
	@IBOutlet weak var conditionLabel: UILabel!
	@IBOutlet weak var tempLabel: UILabel!
	
	func fillCell(with data: Weather) {
		self.nameCityLabel.text = data.cityName
		self.conditionLabel.text = data.conditionRus
		self.tempLabel.text = data.tempStr
	}
}
