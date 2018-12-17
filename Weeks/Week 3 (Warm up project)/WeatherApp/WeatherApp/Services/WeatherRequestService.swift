//
//  WeatherRequestService.swift
//  WeatherApp
//
//  Created by Korel Hayrullah on 15.11.2018.
//  Copyright © 2018 Korel Hayrullah. All rights reserved.
//

import Foundation
import Alamofire

class WeatherRequestService {
  // MARK: -Typealiases
  typealias Completion = ([WeatherForecastSection]?) -> Void
  
  // MARK: -Properties
  private let API_KEY = "YOUR KEY HERE"
  
  static let shared: WeatherRequestService = WeatherRequestService()
  
  // MARK: -Methods
  private init() {}
  
  func requestWithAlamofire(cityName: String, completion: @escaping Completion) {
    let url = completeURL(with: cityName)

    Alamofire.request(url).validate().response { [weak self] (response) in
      guard let `self` = self else { return }
      if let error = response.error {
        print(error.localizedDescription)
        return
      }
      
      guard let data = response.data else { return }
      completion(self.handleData(data: data))
    }
  }
  
  func requestWithURLSession(cityName: String, completion: @escaping Completion) {
    let url = completeURL(with: cityName)
    
    URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
      guard let `self` = self else { return }
      
      if let error = error {
        print("Error: \(error.localizedDescription)")
        return
      }
      
      guard let data = data else { return }
      completion(self.handleData(data: data))
    }.resume()
  }
  
  private func handleData(data: Data) -> [WeatherForecastSection]? {
    do {
      let dataDict = try JSONSerialization.jsonObject(with: data, options: []) as! [String : Any]
      
      guard let list = dataDict["list"] as? [[String : Any]] else { return nil }
      
      let listData = try JSONSerialization.data(withJSONObject: list, options: [])
      
      let weatherForecastModels = try JSONDecoder().decode([WeatherForecastModel].self, from: listData)
    
      return sectionModels(weatherForecastModels: weatherForecastModels)
      
    } catch let err {
      print("Error: \(err.localizedDescription)")
    }
    return nil
  }
  
  private func sectionModels(weatherForecastModels: [WeatherForecastModel]) -> [WeatherForecastSection] {
    
    var sectionedModel: [String: [WeatherForecastModel]] = [:]
    for weatherForecastModel in weatherForecastModels {
      let key = String(weatherForecastModel.dt.dateFormatted.split(separator: "@")[0])
      
      if sectionedModel[key] == nil {
        sectionedModel[key] = []
      }
      sectionedModel[key]!.append(weatherForecastModel)
    }
    
    var weatherForecastSections: [WeatherForecastSection] = []
    
    for sectionedModelKey in sectionedModel.keys {
      let newWeatherForecastSection = WeatherForecastSection(date: sectionedModelKey, weatherForecast: sectionedModel[sectionedModelKey]!)
      weatherForecastSections.append(newWeatherForecastSection)
    }
    
    return weatherForecastSections
  }
  
  
  private func completeURL(with cityName: String) -> URL {
    let formattedCityName = cityName.replacingOccurrences(of: " ", with: "%20")
    let url = URL(string: "http://api.openweathermap.org/data/2.5/forecast?q=\(formattedCityName)&appid=\(API_KEY)")!
    print("Sending request to: \(url)")
    return url
    
    // sample
    //return URL(string: "https://samples.openweathermap.org/data/2.5/forecast?q=\(name)&appid=\(API_KEY)")!
  }
}
