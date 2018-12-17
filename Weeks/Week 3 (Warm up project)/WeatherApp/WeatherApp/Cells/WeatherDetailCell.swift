//
//  WeatherDetailCell.swift
//  WeatherApp
//
//  Created by Korel Hayrullah on 15.11.2018.
//  Copyright © 2018 Korel Hayrullah. All rights reserved.
//

import UIKit

let WEATHER_DETAIL_CELL_ID = "WeatherDetailCellID"

class WeatherDetailCell: UITableViewCell {
  // MARKK: Properties
  @IBOutlet weak var timeLabel: UILabel!
  @IBOutlet weak var tempAvgLabel: UILabel!
  @IBOutlet weak var tempMaxLabel: UILabel!
  @IBOutlet weak var tempMinLabel: UILabel!
  @IBOutlet weak var weatherLabel: UILabel!
  @IBOutlet weak var windLabel: UILabel!
  @IBOutlet weak var humidityLabel: UILabel!
  
  // MARK: -Methods
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    initialize()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  private func initialize() {
    
  }
  
  func configureCell(with model: WeatherForecastModel) {
    timeLabel.text = String(model.dt.dateFormatted.split(separator: "@")[1])
    tempAvgLabel.text = "Avg Temp: \(model.main.temp.toCelsius)°"
    tempMaxLabel.text = "Max Temp: \(model.main.temp_max.toCelsius)°"
    tempMinLabel.text = "Min Temp: \(model.main.temp_min.toCelsius)°"
    weatherLabel.text = "Weather: \(model.weather[0].main)"
    windLabel.text = "Wind: \(model.wind.speed)"
    humidityLabel.text = "Humidity: \(model.main.humidity)"
  }
}
