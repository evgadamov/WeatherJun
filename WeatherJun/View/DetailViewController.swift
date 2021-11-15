//
//  DetailViewController.swift
//  WeatherJun
//
//  Created by Evgeny Adamov on 27.09.2021.
//

import UIKit
import SwiftSVG

class DetailViewController: UIViewController {
	
	var weatherModel: Weather?

	@IBOutlet var cityNameLabel: UILabel!
	@IBOutlet var conditionIconView: UIView!
	@IBOutlet var conditionLabel: UILabel!
	@IBOutlet var tempLabel: UILabel!
	
	override func viewDidLoad() {
        super.viewDidLoad()
		

        
    }
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		fillData()
	}
    
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		
	}
	
	func fillData() {
		guard let weatherModel = weatherModel else {
			return
		}
		
		self.cityNameLabel.text = weatherModel.cityName
		self.conditionLabel.text = weatherModel.conditionRus
		self.tempLabel.text = weatherModel.tempStr
		
		if let url = URL(string: "https://yastatic.net/weather/i/icons/funky/dark/\(weatherModel.icon).svg") {
			let svgView = UIView(SVGURL: url) { svgImage in
				svgImage.resizeToFit(self.conditionIconView.bounds)
			}
			self.conditionIconView.addSubview(svgView)
		}
	}
}
