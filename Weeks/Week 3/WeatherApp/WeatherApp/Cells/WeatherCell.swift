//
//  WeatherCell.swift
//  WeatherApp
//
//  Created by Korel Hayrullah on 22.11.2018.
//  Copyright © 2018 Korel Hayrullah. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell {
  // MARK: -Properties
  @IBOutlet weak var timeLabel: UILabel!
  @IBOutlet weak var tempLabel: UILabel!
  @IBOutlet weak var tempMaxLabel: UILabel!
  @IBOutlet weak var tempMinLabel: UILabel!
  @IBOutlet weak var humidityLabel: UILabel!
  @IBOutlet weak var pressureLabel: UILabel!
  @IBOutlet weak var weatherLabel: UILabel!
  
  // MARK: -Methods
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  func configureCell(model: WeatherForecastModel) {
    let formattedDate = model.dt.formattedDate
    timeLabel.text = String(formattedDate.split(separator: "@")[1])
    tempLabel.text = "Temp: " + model.main.temp.toKelvin
    tempMaxLabel.text = "Temp max: " + model.main.temp_max.toKelvin
    tempMinLabel.text = "Temp min: " + model.main.temp_min.toKelvin
    weatherLabel.text = "Weather: \(model.weather[0].description)"
    pressureLabel.text = "Pressure: \(model.main.pressure)"
    humidityLabel.text = "Humidity: \(model.main.humidity)"
  }
}
