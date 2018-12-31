//
//  LoadingViewController.swift
//  QuizifyApp
//
//  Created by Korel Hayrullah on 13.12.2018.
//  Copyright © 2018 Korel Hayrullah. All rights reserved.
//

import UIKit

class LoadingViewController: UIViewController {
  // MARK: -Properties
  @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
  @IBOutlet weak var containerView: UIView!
  weak var parentVC: UIViewController?
  
  // MARK: -Methods
  override func viewDidLoad() {
    super.viewDidLoad()
    containerView.layer.cornerRadius = 30
    containerView.layer.masksToBounds = true
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    loadingIndicator.startAnimating()
  }
  
  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    loadingIndicator.stopAnimating()
  }
  
  func show(parentVC: UIViewController, animated: Bool = false) {
    self.parentVC = parentVC
    modalPresentationStyle = .overCurrentContext
    modalTransitionStyle = .crossDissolve
    DispatchQueue.main.async { [unowned self] in
      parentVC.present(self, animated: animated, completion: nil)
    }
  }
  
  func hide() {
    parentVC?.dismiss(animated: true, completion: nil)
  }
}
