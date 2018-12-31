//
//  AuthenitcationViewController.swift
//  QuizifyApp
//
//  Created by Korel Hayrullah on 11.12.2018.
//  Copyright © 2018 Korel Hayrullah. All rights reserved.
//

import UIKit
import FirebaseAuth

class AuthenticationViewController: UIViewController {
  // MARK: -Properties
  @IBOutlet weak var emailTF: UITextField!
  @IBOutlet weak var passwordTF: UITextField!
  @IBOutlet weak var authenticateBtn: UIButton!
  
  // MARK: -Methods
  override func viewDidLoad() {
    super.viewDidLoad()
    authenticateBtn.layer.cornerRadius = 4
    emailTF.delegate = self
    passwordTF.delegate = self
    
    if let currentUser = Auth.auth().currentUser {
      print("Logged user:", currentUser.displayName ?? "No name set yet.")
      performSegue(withIdentifier: "MainViewControllerSegue", sender: nil)
    } else {
      print("No cached user.")
    }
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    view.endEditing(true)
  }
  
  // MARK: -Actions
  @IBAction func segmentedControlValueChanged(_ sender: UISegmentedControl) {
    authenticateBtn.tag = sender.selectedSegmentIndex
    if sender.selectedSegmentIndex == 0 {
      authenticateBtn.setTitle("Login", for: .normal)
    } else {
      authenticateBtn.setTitle("Sign Up", for: .normal)
    }
  }
  
  
  @IBAction func authenticateBtnPressed(_ sender: UIButton) {
    view.endEditing(true)
    guard let email = emailTF.text, let pass = passwordTF.text else { return }
    
    if email.count != 0 && pass.count != 0 {
      if email.isEmailValid {
        if sender.tag == 0 {
          let loadingViewController = UIStoryboard.getLoadingViewController()
          loadingViewController.show(parentVC: self)
          
          Auth.auth().signIn(withEmail: email, password: pass) { (result, error) in
            loadingViewController.hide()
            
            if let error = error {
              print("[Auth Error]: ", error.localizedDescription)
              UIAlertController.showDefaultError(vc: self, message: error.localizedDescription)
            } else {
              self.performSegue(withIdentifier: "MainViewControllerSegue", sender: nil)
            }
          }
        } else {
          let loadingViewController = UIStoryboard.getLoadingViewController()
          loadingViewController.show(parentVC: self)
          
          Auth.auth().createUser(withEmail: email, password: pass) { (result, error) in
            loadingViewController.hide()
            if let error = error {
              print("[Auth Error]: ", error.localizedDescription)
              UIAlertController.showDefaultError(vc: self, message: error.localizedDescription)
            } else {
              let data: [String : Any] = [
                "email" : email,
                "total_score" : 0,
                "timestamp" : Date().timeIntervalSince1970
              ]
              
              DBService.shared.createUser(data: data, completion: { error in
                if let error = error {
                  UIAlertController.showDefaultError(vc: self, message: error.localizedDescription)
                } else {
                  self.performSegue(withIdentifier: "MainViewControllerSegue", sender: nil)
                }
              })
            }
          }
        }
      } else {
        UIAlertController.showDefaultError(vc: self, message: "Email not valid :(")
        
      }
    } else {
      UIAlertController.showDefaultError(vc: self, message: "Something went wrong :(")
    }
  }
}

// MARK: -UITextFieldDelegate
extension AuthenticationViewController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    if textField == emailTF {
      passwordTF.becomeFirstResponder()
    } else {
      authenticateBtn.sendActions(for: .touchUpInside)
    }
    return true
  }
}
