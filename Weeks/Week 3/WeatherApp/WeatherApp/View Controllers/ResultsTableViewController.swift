//
//  ResultsTableViewController.swift
//  WeatherApp
//
//  Created by Korel Hayrullah on 15.11.2018.
//  Copyright © 2018 Korel Hayrullah. All rights reserved.
//

import UIKit

extension Double {
  var formattedDate: String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd MMMM yyyy@HH:mm"
    let date = Date(timeIntervalSince1970: self)
    return dateFormatter.string(from: date)
  }
  
  var toKelvin: String {
    return String(Int(self - 273))
  }
}

struct SectionWeatherForecast {
  let date: String
  let weatherForecasts: [WeatherForecastModel]
  
  init(date: String, weatherForecasts: [WeatherForecastModel]) {
    self.date = date
    self.weatherForecasts = weatherForecasts
  }
}

struct WeatherForecastModel: Codable {
  let dt: Double
  let main: MainModel
  let weather: [WeatherModel]
  let dt_txt: String
}

struct MainModel: Codable {
  let temp: Double
  let temp_min: Double
  let temp_max: Double
  let pressure: Double
  let humidity: Double
}

struct WeatherModel: Codable {
  let id: Int
  let main: String
  let description: String
}

class ResultsTableViewController: UITableViewController {
  // MARK: -Properties
  public var city: String!
  private let API_KEY = "YOUR API KEY HERE"
  
  private var sectionWeatherForecasts: [SectionWeatherForecast] = []
  
  // MARK: -Methods
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationItem.title = city
    
    let url = getURL(cityName: city)

    URLSession.shared.dataTask(with: url) { (data, response, error) in
      if let err = error {
        print(err.localizedDescription)
        return
      }
      
      if let data = data {
        do {
          let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String : Any]
          
          guard let listDict = json["list"] as? [[String: Any]] else { return }
          
          let listData = try JSONSerialization.data(withJSONObject: listDict, options: [])
          
          let weatherForecasts = try JSONDecoder().decode([WeatherForecastModel].self, from: listData)
  
          var sectionedDict: [String : [WeatherForecastModel]] = [:]
          
          for weatherForecast in weatherForecasts {
            let formattedDate = weatherForecast.dt.formattedDate
            let key = String(formattedDate.split(separator: "@")[0])
            
            if sectionedDict[key] == nil {
              sectionedDict[key] = []
            }
            sectionedDict[key]!.append(weatherForecast)
          }
          
          for (key, values) in sectionedDict {
            let sectionWeatherForecast = SectionWeatherForecast(date: key,weatherForecasts: values)
            self.sectionWeatherForecasts.append(sectionWeatherForecast)
          }
          
          self.tableView.reloadData()
          
        } catch let jsonError {
          print(jsonError.localizedDescription)
        }
      }
    }.resume()
  }
  
  func getURL(cityName: String) -> URL {
    return URL(string: "http://api.openweathermap.org/data/2.5/forecast?q=\(cityName)&appid=\(API_KEY)")!
  }
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return sectionWeatherForecasts.count
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return sectionWeatherForecasts[section].weatherForecasts.count
  }
  
  override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return sectionWeatherForecasts[section].date
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell", for: indexPath) as? WeatherCell else {
      fatalError("Dequeued cell is not an instance of WeatherCell!")
    }
    let weatherForecastModel = sectionWeatherForecasts[indexPath.section].weatherForecasts[indexPath.row]
    cell.configureCell(model: weatherForecastModel)
    return cell
  }
}
