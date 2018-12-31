//
//  UIAlertController+Ext.swift
//  QuizifyApp
//
//  Created by Korel Hayrullah on 31.12.2018.
//  Copyright © 2018 Korel Hayrullah. All rights reserved.
//

import UIKit

extension UIAlertController {
  class func showDefaultError(vc: UIViewController, message: String, okAction: ((UIAlertAction) -> Void)? = nil) {
    let alert = UIAlertController(title: "Hey", message: message, preferredStyle: .alert)
    let okAction = UIAlertAction(title: "OK", style: .default, handler: okAction)
    alert.addAction(okAction)
    vc.present(alert, animated: true, completion: nil)
  }
}
