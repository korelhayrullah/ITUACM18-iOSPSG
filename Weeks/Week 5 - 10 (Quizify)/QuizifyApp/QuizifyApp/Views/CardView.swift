//
//  CardView.swift
//  QuizifyApp
//
//  Created by Korel Hayrullah on 10.12.2018.
//  Copyright © 2018 Korel Hayrullah. All rights reserved.
//

import UIKit
import Koloda


class CardView: UIView {
  // MARK: -Properties
  private lazy var questionTitleLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textAlignment = .center
    label.textColor = .white
    return label
  }()
  
  private lazy var questionLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.numberOfLines = 0
    label.textAlignment = .center
    label.textColor = .white
    return label
  }()
  
  private lazy var buttonStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .vertical
    stackView.distribution = .fillEqually
    stackView.alignment = .fill
    stackView.spacing = 16
    return stackView
  }()
  
  private var answerButtons: [UIButton] = []
  
  private var colors: [UIColor] {
    return [
      Styles.Colors.green,
      Styles.Colors.red,
      Styles.Colors.blue
    ]
  }
  
  private lazy var selectedRandomColor: UIColor = {
    return colors.randomElement()!
  }()
  
  var quizModel: QuizModel!
  weak var delegate: CardViewDelegate?
  
  // MARK: -Methods
  init(questionNumber: Int, quizModel: QuizModel) {
    super.init(frame: CGRect.zero)
    initialize()
    configureView(questionNumber: questionNumber, with: quizModel)
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    initialize()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    initialize()
  }
  
  private func initialize() {
    layer.cornerRadius = 12
    layer.masksToBounds = true
    backgroundColor = selectedRandomColor
    addSubview(questionTitleLabel)
    
    NSLayoutConstraint.activate([
      questionTitleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
      questionTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
      questionTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
      questionTitleLabel.heightAnchor.constraint(equalToConstant: 30)
      ])
    
    addSubview(questionLabel)
    
    NSLayoutConstraint.activate([
      questionLabel.topAnchor.constraint(equalTo: questionTitleLabel.bottomAnchor, constant: 16),
      questionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
      questionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
      ])
    
    addSubview(buttonStackView)
    NSLayoutConstraint.activate([
      buttonStackView.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 16),
      buttonStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
      buttonStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
      buttonStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
      ])
  }
  
  private func createButton(with title: String, tag: Int) -> UIButton {
    let button = UIButton(type: .system)
    button.tag = tag
    button.layer.cornerRadius = 12
    button.backgroundColor = .white
    button.tintColor = selectedRandomColor
    button.setTitle(title, for: .normal)
    button.addTarget(self, action: #selector(answerButtonDidPress(_:)), for: .touchUpInside)
    return button
  }
  
  func configureView(questionNumber: Int, with model: QuizModel) {
    self.quizModel = model
    
    self.questionTitleLabel.text = "Question \(questionNumber)"
    self.questionLabel.text = model.question
    
    for (index, answer) in model.answers.enumerated() {
      let newAnswerButton = createButton(with: answer, tag: index)
      answerButtons.append(newAnswerButton)
      buttonStackView.addArrangedSubview(newAnswerButton)
    }
  }

  @objc
  func answerButtonDidPress(_ sender: UIButton) {
    let selectedAnswer = answerButtons[sender.tag].titleLabel?.text
    
    if selectedAnswer == quizModel.correctAnswer {
      quizModel.isMyAnswerCorrect = true
    }
    
    guard let delegate = delegate else { return }
    delegate.cardViewDidPressCard(self, quizModel: quizModel)
  }
}
