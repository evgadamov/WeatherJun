	//
	//  ListTableViewController.swift
	//  WeatherJun
	//
	//  Created by Evgeny Adamov on 26.09.2021.
	//

import UIKit

class ListTableViewController: UITableViewController {
	
	let searchController: UISearchController = {
		let searchController = UISearchController(searchResultsController: nil)
		searchController.obscuresBackgroundDuringPresentation = false
		searchController.searchBar.placeholder = "Введите название города..."
		return searchController
	}()
	
	var searchBarIsEmpty: Bool {
		guard let text = searchController.searchBar.text else { return false }
		return text.isEmpty
	}
	
	var isFiltering: Bool {
		return searchController.isActive && !searchBarIsEmpty
	}
	
	
	var weathers: [String: Weather] = [:] {
		didSet {
			DispatchQueue.main.async {
				self.tableView.reloadData()
			}
		}
	}
	var filterWeathers: [String: Weather] = [:]
	var filterNameCity = [String]()
	
	var nameCitiesArray = [
		"Москва",
		"Санкт-Петербург",
		"Новосибирск",
		"Екатеринбург",
		"Казань",
		"Нижний Новгород",
		"Челябинск",
		"Самара",
		"Омск",
		"Ростов-на-Дону",
		"Грозный"
	]
	
	let networkManager = NetworkManager()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		addWeatherToArray()
		searchController.searchResultsUpdater = self
		navigationItem.searchController = searchController
		definesPresentationContext = true
	}
	
	@IBAction func addCityDidTapped(_ sender: UIBarButtonItem) {
		alertAddCity(with: "Город", placeholder: "Введите название города...") { city in
			
			getCoordinate(from: city) { coordinate, cityName, error in
				if let city = cityName,
				   self.addByTapPlusButton(city: city) {
					self.addWeatherToArray()
				}
			}
		}
	}
	
	
	func addByTapPlusButton(city: String) -> Bool {
		guard !nameCitiesArray.contains(city) else { return false }
		nameCitiesArray.append(city)
		return nameCitiesArray.contains(city)
	}
	
	func addName(of city: String) {
#warning("доделать")
	}
	
	
	func addWeatherToArray() {
		getCitiesWeather(citiesArray: nameCitiesArray) { city, weather in
			
			self.weathers[city] = weather
			self.weathers[city]?.cityName = city
//			DispatchQueue.main.async {
//				self.tableView.reloadData()
//			}
		}
	}
	
		// MARK: - Delete items
	
	override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
		
		let deleteAction = UIContextualAction(style: .destructive, title: "Удалить") { _, _, completionHandler in
			let keyForEdit = self.nameCitiesArray[indexPath.row]
			if let _ = self.weathers.removeValue(forKey: keyForEdit) {
				self.nameCitiesArray.remove(at: indexPath.row)
				DispatchQueue.main.async {
					tableView.deleteRows(at: [indexPath], with: .automatic)
				}
			}
		}
		return UISwipeActionsConfiguration(actions: [deleteAction])
	}
	
	
		// MARK: - Navigation
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "showDetail",
		   let indexPath = tableView.indexPathForSelectedRow,
		   let weather = getWeatherForCity(index: indexPath.row) {
			let destVC = segue.destination as! DetailViewController
			destVC.weatherModel = weather
		}
	}
	
	func getWeatherForCity(index: Int) -> Weather? {
		let cityKey = nameCitiesArray[index]
		let weather = weathers[cityKey]
		return weather
	}
	
	
	
	
		// MARK: - Table view data source
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		
		if isFiltering {
			return filterWeathers.count
		} else {
			return weathers.count
		}
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "weather", for: indexPath) as! WeatherCell
		
		
		
		if isFiltering {
			let cityKey = filterNameCity[indexPath.row]
			if let weather = filterWeathers[cityKey] {
				cell.fillCell(with: weather)
			}
		} else {
			let cityKey = nameCitiesArray[indexPath.row]
			if let weather = weathers[cityKey] {
				cell.fillCell(with: weather)
			}
		}
		
		return cell
	}
	
	func test() {
		weathers.keys
	}
	
}

extension ListTableViewController: UISearchResultsUpdating {
	func updateSearchResults(for searchController: UISearchController) {
		guard let text = searchController.searchBar.text else { return }
		filteringResult(search: text)
	}
	
	private func filteringResult(search text: String) {
		filterWeathers = weathers.filter { $0.key.contains(text) }
		filterNameCity = nameCitiesArray.filter { $0.contains(text) }
		
		tableView.reloadData()
	}
	
	
}
