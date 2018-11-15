//
//  SearchViewController.swift
//  WeatherApp
//
//  Created by Korel Hayrullah on 15.11.2018.
//  Copyright © 2018 Korel Hayrullah. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
  // MARK: -Properties
  @IBOutlet weak var weatherForecastLabel: UILabel!
  @IBOutlet weak var searchTextField: UITextField!
  @IBOutlet weak var searchBtn: UIButton!
  @IBOutlet weak var stackView: UIStackView!
  @IBOutlet var stackViewCenterYConstraint: NSLayoutConstraint!
  private var stackViewTopConstraint: NSLayoutConstraint!
  
  // MARK: -Methods
  override func viewDidLoad() {
    super.viewDidLoad()
    searchTextField.delegate = self
    stackViewTopConstraint = stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0)
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    view.endEditing(true)
  }
  
  func snapStackViewToTop(snap: Bool) {
    if snap {
      stackViewTopConstraint.isActive = true
      stackViewCenterYConstraint.isActive = false
    } else {
      stackViewTopConstraint.isActive = false
      stackViewCenterYConstraint.isActive = true
    }
    
    UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.8, options: .curveEaseOut, animations: { [unowned self] in
      // unowned self is used here to avoid capturing the self object
      // causing a strong relationship which results in memory leaks
      self.view.layoutIfNeeded()
    }, completion: nil)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard let cityName = sender as? String else { return }
    
    if segue.identifier == "ResultsViewControllerSegue" {
      if let resultsViewController = segue.destination as? ResultsViewController {
        resultsViewController.city = cityName
      }
    }
  }
  
  // MARK: -Actions
  @IBAction func searchButtonPressed(_ sender: UIButton) {
    view.endEditing(true)
    guard let text = searchTextField.text else { return }
    
    let trimmedText = text.trimmingCharacters(in: .whitespacesAndNewlines)
    
    
    if trimmedText.count != 0 {
      performSegue(withIdentifier: "ResultsViewControllerSegue", sender: trimmedText)
    } else {
      let alert = UIAlertController(title: "Upss!",
                                    message: "Fields cannot be empty!",
                                    preferredStyle: .alert)
      
      let alertAction = UIAlertAction(title: "Ups!",
                                      style: .default,
                                      handler: nil)
      
      alert.addAction(alertAction)
      present(alert, animated: true, completion: nil)
      
    }
    // clear text field
    searchTextField.text = ""
  }
}

// MARK: -UITextFieldDelegate
extension SearchViewController: UITextFieldDelegate {
  func textFieldDidBeginEditing(_ textField: UITextField) {
    snapStackViewToTop(snap: true)
  }
  
  func textFieldDidEndEditing(_ textField: UITextField) {
    snapStackViewToTop(snap: false)
  }
}



