//
//  CardViewDelegate.swift
//  QuizifyApp
//
//  Created by Korel Hayrullah on 11.12.2018.
//  Copyright © 2018 Korel Hayrullah. All rights reserved.
//

import Foundation

protocol CardViewDelegate: class {
  func cardViewDidPressCard(_ cardView: CardView, quizModel: QuizModel)
}
