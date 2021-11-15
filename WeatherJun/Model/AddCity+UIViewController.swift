//
//  AddCity+UIViewController.swift
//  WeatherJun
//
//  Created by Evgeny Adamov on 27.09.2021.
//

import UIKit

extension UIViewController {
	func alertAddCity(with name: String, placeholder: String, completionHandler: @escaping (String) -> Void) {
		let alertController = UIAlertController(title: name, message: nil, preferredStyle: .alert)
		
		let alertOkButton = UIAlertAction(title: "Ok", style: .default) { action in
			let tftext = alertController.textFields?.first?.text
			guard let text = tftext else { return }
			completionHandler(text)
		}
		
		let alertCancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
		
		alertController.addTextField { tf in
			tf.placeholder = placeholder
		}
		
		alertController.addAction(alertOkButton)
		alertController.addAction(alertCancelButton)
		
		present(alertController, animated: true, completion: nil) 
	}
}
