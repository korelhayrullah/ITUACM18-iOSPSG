//
//  SearchViewController.swift
//  WeatherApp
//
//  Created by Korel Hayrullah on 15.11.2018.
//  Copyright © 2018 Korel Hayrullah. All rights reserved.
//

import UIKit

import UIKit

class SearchViewController: UIViewController {
  // MARK: -Properties
  @IBOutlet weak var searchTextField: UITextField!
  @IBOutlet var stackViewCenterYConstraint: NSLayoutConstraint!
  @IBOutlet weak var stackView: UIStackView!
  @IBOutlet weak var searchButton: UIButton!
  private var stackViewTopConstraint: NSLayoutConstraint!
  
  // MARK: -Methods
  override func viewDidLoad() {
    super.viewDidLoad()
    searchTextField.delegate = self
    configureUI()
  }
  
  private func configureUI() {
    searchButton.layer.cornerRadius = 4
    stackViewTopConstraint = stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8)
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
    
    UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.6, options: .curveEaseOut, animations: { [unowned self] in
      self.view.layoutIfNeeded()
      }, completion: nil)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard let cityName = sender as? String else { return }
    if segue.identifier == "WeatherResultsTableViewControllerSegue" {
      if let weatherResultsTableViewController = segue.destination as? WeatherResultsTableViewController {
        weatherResultsTableViewController.cityName = cityName
      }
    }
  }
  
  // MARK: -Action
  @IBAction func searchButtonPressed(_ sender: UIButton) {
    guard let text = searchTextField.text else { return }
    let trimmedText = text.trimmingCharacters(in: .whitespacesAndNewlines)
    
    if trimmedText.count != 0 {
      performSegue(withIdentifier: "WeatherResultsTableViewControllerSegue", sender: trimmedText)
    } else {
      let alert = UIAlertController(title: "Hey", message: "Fields cannot be left blank!", preferredStyle: .alert)
      let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil  )
      alert.addAction(alertAction)
      present(alert, animated: true, completion: nil)
    }
    
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
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    searchButton.sendActions(for: .touchUpInside)
    return true
  }
}
