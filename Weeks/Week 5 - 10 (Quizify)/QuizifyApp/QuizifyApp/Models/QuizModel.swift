//
//  QuizModel.swift
//  QuizifyApp
//
//  Created by Korel Hayrullah on 10.12.2018.
//  Copyright © 2018 Korel Hayrullah. All rights reserved.
//

import Foundation

struct QuizModel {
  let question: String
  let answers: [String]
  let correctAnswer: String
  let myAnswer: String
  var isMyAnswerCorrect: Bool
  
  init(question: String, answers: [String], correctAnswer: String) {
    self.question = question
    self.answers = answers
    self.correctAnswer = correctAnswer
    self.myAnswer = ""
    self.isMyAnswerCorrect = false
  }
}
