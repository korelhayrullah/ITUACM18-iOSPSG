//
//  String+Ext.swift
//  QuizifyApp
//
//  Created by Korel Hayrullah on 11.12.2018.
//  Copyright © 2018 Korel Hayrullah. All rights reserved.
//

import Foundation

extension String {
  var isEmailValid: Bool {
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailTest.evaluate(with: self)
  }
}
