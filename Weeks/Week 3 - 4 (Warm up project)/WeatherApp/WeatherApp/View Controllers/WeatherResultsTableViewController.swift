//
//  ResultsTableViewController.swift
//  WeatherApp
//
//  Created by Korel Hayrullah on 15.11.2018.
//  Copyright © 2018 Korel Hayrullah. All rights reserved.
//

import UIKit
import Alamofire

class WeatherResultsTableViewController: UITableViewController {
  // MARK: -Properties
  public var cityName: String!
  
  private var weatherForecastSections: [WeatherForecastSection] = [] {
    didSet {
      // sort sections
      // not good $0.weatherForecast[0].dt < $1.weatherForecast[0].dt
      // may become index out of range in case no weatherForecast returns
      weatherForecastSections.sort { return $0.weatherForecast[0].dt < $1.weatherForecast[0].dt }
      
      // sort weather by time in every section
      for var weatherForecastSection in weatherForecastSections {
        weatherForecastSection.weatherForecast.sort {
          return $0.dt < $1.dt
        }
      }
      
      DispatchQueue.main.async { [unowned self] in
        self.tableView.reloadData()
      }
    }
  }
  
  // MARK: -Methods
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationItem.title = cityName
    
    // Uncomment between URL Session and Alamofire to inspect!!!
    
    // Alamofire
    //    WeatherRequestService.shared.requestWithAlamofire(cityName: cityName) { [weak self] weatherForecastSections in
    //      guard let `self` = self else { return }
    //      if let _weatherForecastSections = weatherForecastSections {
    //        self.weatherForecastSections = _weatherForecastSections
    //      } else {
    //        DispatchQueue.main.async {
    //          self.showError()
    //        }
    //      }
    //    }
    
    
    // URL Session
    WeatherRequestService.shared.requestWithURLSession(cityName: cityName) { [weak self] weatherForecastSections in
      guard let `self` = self else { return }
      if let _weatherForecastSections = weatherForecastSections {
        self.weatherForecastSections = _weatherForecastSections
      } else {
        DispatchQueue.main.async {
          self.showError()
        }
      }
    }
  }
  
  private func showError() {
    let alert = UIAlertController(title: "Upss!",
                                  message: "City could not be found",
                                  preferredStyle: .alert)
    let okAction = UIAlertAction(title: "OK", style: .default) { _ in
      self.navigationController?.popViewController(animated: true)
    }
    
    alert.addAction(okAction)
    
    present(alert, animated: true, completion: nil)
  }
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return weatherForecastSections.count
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return weatherForecastSections[section].weatherForecast.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: WEATHER_DETAIL_CELL_ID, for: indexPath) as? WeatherDetailCell else {
      fatalError("Dequeued cell is not an instance of WeatherDetailCell!")
    }
    cell.configureCell(with: weatherForecastSections[indexPath.section].weatherForecast[indexPath.row])
    return cell
  }
  
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 150
  }
  
  override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return weatherForecastSections[section].date
  }
  
  override func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
    let cell = tableView.cellForRow(at: indexPath) as? WeatherDetailCell
    cell?.backgroundColor = .lightGray
  }
  
  override func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
    let cell = tableView.cellForRow(at: indexPath) as? WeatherDetailCell
    cell?.backgroundColor = .white
  }
}
