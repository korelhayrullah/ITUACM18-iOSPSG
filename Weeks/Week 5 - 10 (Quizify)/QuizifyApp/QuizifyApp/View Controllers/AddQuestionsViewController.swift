//
//  AddQuestionsViewController.swift
//  QuizifyApp
//
//  Created by Korel Hayrullah on 27.12.2018.
//  Copyright © 2018 Korel Hayrullah. All rights reserved.
//

import UIKit
import FirebaseAuth

class AddQuestionsViewController: UIViewController {
  // MARK: -Properties
  @IBOutlet weak var containerView: UIView!
  
  @IBOutlet weak var writeQuestionTF: UITextField!
  @IBOutlet weak var firstAnswerTF: UITextField!
  @IBOutlet weak var secondAnswerTF: UITextField!
  @IBOutlet weak var thirdAnswerTF: UITextField!
  @IBOutlet weak var fourthAnswerTF: UITextField!
  
  @IBOutlet weak var firstChoiceBtn: UIButton!
  @IBOutlet weak var secondChoiceBtn: UIButton!
  @IBOutlet weak var thirdChoiceBtn: UIButton!
  @IBOutlet weak var fourthChoiceBtn: UIButton!
  
  @IBOutlet weak var submitQuestionBtn: UIButton!
  
  private var currentSelectedCorrectAnswer: Int = -1
  
  // MARK: -Methods
  override func viewDidLoad() {
    super.viewDidLoad()
    containerView.layer.cornerRadius = 10
    
    firstAnswerTF.layer.cornerRadius = 10
    secondAnswerTF.layer.cornerRadius = 10
    thirdAnswerTF.layer.cornerRadius = 10
    fourthAnswerTF.layer.cornerRadius = 10
    
    firstChoiceBtn.layer.cornerRadius = 20
    secondChoiceBtn.layer.cornerRadius = 20
    thirdChoiceBtn.layer.cornerRadius = 20
    fourthChoiceBtn.layer.cornerRadius = 20
    
    submitQuestionBtn.layer.cornerRadius = 10
  }
  
  // MARK: -Actions
  @IBAction func submitQuestionBtnPressed(_ sender: UIButton) {
    view.endEditing(true)
    
    guard let question = writeQuestionTF.text,
      let answer1 = firstAnswerTF.text,
      let answer2 = secondAnswerTF.text,
      let answer3 = thirdAnswerTF.text,
      let answer4 = fourthAnswerTF.text else { return }
    
    if question.count != 0 &&
      answer1.count != 0 &&
      answer2.count != 0 &&
      answer3.count != 0 &&
      answer4.count != 0 &&
      currentSelectedCorrectAnswer != -1 {
      
      let questionData: [String : Any] = [
        "question" : question,
        "a1" : answer1,
        "a2" : answer2,
        "a3" : answer3,
        "a4" : answer4,
        "correct_a" : currentSelectedCorrectAnswer,
        "author" : Auth.auth().currentUser!.uid,
        "random_factor" : UInt32.random(in: 0...UInt32.max - 1)
        ]
      
      let loadingViewController = UIStoryboard.getLoadingViewController()
      loadingViewController.show(parentVC: self)
      
      DBService.shared.addQuestion(data: questionData) { error in
        loadingViewController.hide()
        if error != nil {
          UIAlertController.showDefaultError(vc: self, message: "Something went wrong :(")
        } else {
          DispatchQueue.main.async { [unowned self] in
            self.navigationController?.popViewController(animated: true)
          }
        }
      }
    } else {
      UIAlertController.showDefaultError(vc: self, message: "Something went wrong :(")
    }
  }
  
  @IBAction func choiceButtonsPressed(_ sender: UIButton) {
    currentSelectedCorrectAnswer = sender.tag
    
    firstChoiceBtn.backgroundColor = .white
    secondChoiceBtn.backgroundColor = .white
    thirdChoiceBtn.backgroundColor = .white
    fourthChoiceBtn.backgroundColor = .white
    
    sender.backgroundColor = Styles.Colors.green
  }
}
