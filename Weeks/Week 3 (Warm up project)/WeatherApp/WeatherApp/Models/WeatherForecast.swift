//
//  WeatherForecast.swift
//  WeatherApp
//
//  Created by Korel Hayrullah on 15.11.2018.
//  Copyright © 2018 Korel Hayrullah. All rights reserved.
//

import Foundation

struct WeatherForecastSection {
  let date: String
  var weatherForecast: [WeatherForecastModel]
  
  init(date: String, weatherForecast: [WeatherForecastModel]) {
    self.date = date
    self.weatherForecast = weatherForecast
  }
}

// Codable Models
struct WeatherForecastModel: Codable {
  let dt: Double
  let main: MainModel
  let weather: [WeatherModel]
  let dt_txt: String
  let wind: WindModel
}

struct MainModel: Codable {
  let temp: Double
  let temp_min: Double
  let temp_max: Double
  let pressure: Double
  let sea_level: Double
  let grnd_level: Double
  let humidity: Double
  let temp_kf: Double
}

struct WeatherModel: Codable {
  let id: Int
  let main: String
  let description: String
  let icon: String
}

struct WindModel: Codable {
  let speed: Double
  let deg: Double
}
