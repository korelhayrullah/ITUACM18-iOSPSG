//
//  UIStoryboard+Ext.swift
//  QuizifyApp
//
//  Created by Korel Hayrullah on 29.12.2018.
//  Copyright © 2018 Korel Hayrullah. All rights reserved.
//

import UIKit

extension UIStoryboard {
  class func getLoadingViewController() -> LoadingViewController {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    return storyboard.instantiateViewController(withIdentifier: "LoadingViewController") as! LoadingViewController
  }
}
