//
//  ResultsViewController.swift
//  WeatherApp
//
//  Created by Korel Hayrullah on 15.11.2018.
//  Copyright © 2018 Korel Hayrullah. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {
  // MARK: -Properties
  public var city: String!
  
  // MARK: -Methods
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationItem.title = city
    view.backgroundColor = .red
  }
}
