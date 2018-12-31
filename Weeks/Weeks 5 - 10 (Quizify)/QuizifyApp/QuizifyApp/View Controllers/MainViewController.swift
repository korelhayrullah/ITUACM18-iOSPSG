//
//  MainViewController.swift
//  QuizifyApp
//
//  Created by Korel Hayrullah on 11.12.2018.
//  Copyright © 2018 Korel Hayrullah. All rights reserved.
//

import UIKit
import FirebaseAuth

class MainViewController: UIViewController {
  // MARK: -Properties
  @IBOutlet weak var playGameBtn: UIButton!
  @IBOutlet weak var addQuestionsBtn: UIButton!
  @IBOutlet weak var showLeaderBoardBtn: UIButton!
  @IBOutlet weak var usernameTF: UITextField!
  
  // MARK: -Methods
  override func viewDidLoad() {
    super.viewDidLoad()
    usernameTF.delegate = self
    playGameBtn.layer.cornerRadius = 10
    addQuestionsBtn.layer.cornerRadius = 10
    showLeaderBoardBtn.layer.cornerRadius = 10
    navigationItem.setHidesBackButton(true, animated: false)
    
    if let currentUser = Auth.auth().currentUser {
      usernameTF.text = currentUser.displayName
    }
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    view.endEditing(true)
  }
  
  // MARK: -Actions
  @IBAction func logoutBarBtnItemPressed(_ sender: UIBarButtonItem) {
    do {
      try Auth.auth().signOut()
      navigationController?.popViewController(animated: true)
    } catch {
      print("[Auth Error]:", error.localizedDescription)
    }
    
  }
  
  @IBAction func playGameBtnPressed(_ sender: UIButton) {
    performSegue(withIdentifier: "QuizViewControllerSegue", sender: nil)
  }
  
  @IBAction func addQuestionsBtnPressed(_ sender: UIButton) {
    performSegue(withIdentifier: "AddQuestionsViewControllerSegue", sender: nil)
    
  }
  @IBAction func showLeaderBoardBtnPressed(_ sender: UIButton) {
    performSegue(withIdentifier: "LeaderBoardTableViewControllerSegue", sender: nil)
  }
}


// MARK: -UITextFieldDelegate
extension MainViewController: UITextFieldDelegate {
  func textFieldDidEndEditing(_ textField: UITextField) {
    guard let username = textField.text else { return }
    let trimmedUsername = username.trimmingCharacters(in: .whitespacesAndNewlines)
    
    if !trimmedUsername.isEmpty {
      let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
      changeRequest?.displayName = trimmedUsername
      changeRequest?.commitChanges { [weak self] error in
        guard let `self` = self else { return }
        if let error = error {
          print("[Auth Error]: ", error.localizedDescription)
          UIAlertController.showDefaultError(vc: self, message: error.localizedDescription)
        } else {
          DBService.shared.updateUsername(username: username, completion: { error in
            if let error = error {
              print("[Auth Error]: ", error.localizedDescription)
              UIAlertController.showDefaultError(vc: self, message: error.localizedDescription)
            }
          })
        }
      }
    } else {
      if let currentUser = Auth.auth().currentUser {
        usernameTF.text = currentUser.displayName
      }
    }
  }
}

