//
//  QuestionModel.swift
//  QuizifyApp
//
//  Created by Korel Hayrullah on 27.12.2018.
//  Copyright © 2018 Korel Hayrullah. All rights reserved.
//

import Foundation

struct QuestionModel: Codable {
  let question: String
  let a1: String
  let a2: String
  let a3: String
  let a4: String
  let correct_a: Int
  let author: String
  
  func extractQuizModel() -> QuizModel {
    let answers = [self.a1, self.a2, self.a3, self.a4]
    let correctAnswer = answers[self.correct_a - 1]
    return QuizModel(question: self.question,
                     answers: answers,
                     correctAnswer: correctAnswer)
  }
}
