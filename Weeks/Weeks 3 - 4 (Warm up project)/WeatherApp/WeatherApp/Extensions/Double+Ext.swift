//
//  Double+Ext.swift
//  WeatherApp
//
//  Created by Korel Hayrullah on 15.11.2018.
//  Copyright © 2018 Korel Hayrullah. All rights reserved.
//

import Foundation

extension Double {
  var toCelsius: Int {
    return Int(self - 273.15)
  }
  
  var dateFormatted: String {
    let date = Date(timeIntervalSince1970: self)
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "d MMM EEEE yyyy@HH:mm"
    return dateFormatter.string(from: date)
  }
}
