//
//  QuizViewController.swift
//  QuizifyApp
//
//  Created by Korel Hayrullah on 10.12.2018.
//  Copyright © 2018 Korel Hayrullah. All rights reserved.
//

import UIKit
import Koloda
import FirebaseAuth

class QuizViewController: UIViewController {
  // MARK: -Properties
  @IBOutlet weak var resultsView: UIView!
  @IBOutlet weak var correctAnswersLbl: UILabel!
  @IBOutlet weak var wrongAnswersLbl: UILabel!
  
  private lazy var kolodaView: KolodaView = {
    let _view = KolodaView()
    _view.translatesAutoresizingMaskIntoConstraints = false
    _view.dataSource = self
    _view.delegate = self
    return _view
  }()
  
  private var quizCards: [CardView] = []
  
  // MARK: -Methods
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationItem.setHidesBackButton(true, animated: false)
    
    resultsView.layer.cornerRadius = 12
    resultsView.layer.masksToBounds = true
    resultsView.isHidden = true
    
    view.addSubview(kolodaView)
    
    NSLayoutConstraint.activate([
      kolodaView.heightAnchor.constraint(equalToConstant: 400),
      kolodaView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
      kolodaView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
      kolodaView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
      ])
    
    let loadingController = UIStoryboard.getLoadingViewController()
    loadingController.show(parentVC: self, animated: false)
    
    DBService.shared.getQuestions { [weak self] (quizModels, error) in
      loadingController.hide()
      guard let `self` = self else { return }
      if let error = error {
        UIAlertController.showDefaultError(vc: self, message: error.localizedDescription, okAction: { [unowned self] _ in
          self.navigationController?.popViewController(animated: true)
        })
      } else {
        guard let quizModels = quizModels else { return }
        
        for (index, quizModel) in quizModels.enumerated() {
          let newCardView = CardView(questionNumber: index + 1, quizModel: quizModel)
          newCardView.delegate = self
          self.quizCards.append(newCardView)
        }
        self.kolodaView.reloadData()
      }
    }
  }
  
  private func giveResuts() {
    var correctAnswers = 0
    for quizCard in quizCards {
      if quizCard.quizModel.isMyAnswerCorrect {
        correctAnswers += 1
      }
    }
    correctAnswersLbl.text = "Correct answers: \(correctAnswers)"
    wrongAnswersLbl.text = "Wrong answers: \(quizCards.count - correctAnswers)"
    kolodaView.isHidden = true
    resultsView.transform = CGAffineTransform(scaleX: 0, y: 0)
    resultsView.isHidden = false
    UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
      self.resultsView.transform = CGAffineTransform.identity
    }, completion: nil)
    
    let loadingController = UIStoryboard.getLoadingViewController()
    loadingController.show(parentVC: self)
    DBService.shared.updateScore(correctAnswers: correctAnswers) { _ in
      loadingController.hide()
    }
  }
  
  // MARK: -Actions
  @IBAction func quitBarBtnItemPressed(_ sender: UIBarButtonItem) {
    let alert = UIAlertController(title: "Hey",
                                  message: "Are you sure you want to quit?", preferredStyle: .alert)
    
    let okAction = UIAlertAction(title: "OK", style: .default) { _ in
      self.navigationController?.popViewController(animated: true)
    }
    let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
    alert.addAction(okAction)
    alert.addAction(cancelAction)
    
    present(alert, animated: true, completion: nil)
  }
  
  @IBAction func playAgainBtnPressed(_ sender: UIButton) {
    // TODO: API CALL
    UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
      self.resultsView.transform = CGAffineTransform(scaleX: 0, y: 0)
    }) { _ in
      self.resultsView.isHidden = true
      self.resultsView.transform = CGAffineTransform.identity
      self.kolodaView.isHidden = false
    }
    kolodaView.resetCurrentCardIndex()
  }
}


// MARK: -KolodaViewDataSource
extension QuizViewController: KolodaViewDataSource {
  func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {
    return quizCards[index]
  }
  
  func kolodaNumberOfCards(_ koloda: KolodaView) -> Int {
    return quizCards.count
  }
}

// MARK: -KolodaViewDelegate
extension QuizViewController: KolodaViewDelegate {
  func koloda(_ koloda: KolodaView, shouldSwipeCardAt index: Int, in direction: SwipeResultDirection) -> Bool {
    return false
  }
  
  func koloda(_ koloda: KolodaView, didSwipeCardAt index: Int, in direction: SwipeResultDirection) {
    if index == quizCards.count - 1 {
      giveResuts()
    }
  }
}

// MARK: -CardViewDelegate
extension QuizViewController: CardViewDelegate {
  func cardViewDidPressCard(_ cardView: CardView, quizModel: QuizModel) {
    kolodaView.swipe(Int.random(in: 0...1) % 2 == 0 ? .left : .right, force: true)
  }
}

