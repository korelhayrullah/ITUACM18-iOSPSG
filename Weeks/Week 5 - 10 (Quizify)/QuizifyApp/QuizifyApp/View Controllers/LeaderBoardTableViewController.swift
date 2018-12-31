//
//  LeaderBoardTableViewController.swift
//  QuizifyApp
//
//  Created by Korel Hayrullah on 11.12.2018.
//  Copyright © 2018 Korel Hayrullah. All rights reserved.
//

import UIKit

class LeaderBoardTableViewController: UITableViewController {
  // MARK: -Properties
  private var userRecords: [LeaderboardModel] = []
  
  // MARK: -Methods
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let loadingController = UIStoryboard.getLoadingViewController()
    loadingController.show(parentVC: self, animated: false)
    
    DBService.shared.fetchLeaderboard { [weak self] (leaders, error) in
      loadingController.hide()
      guard let `self` = self else { return }
      if let error = error {
        UIAlertController.showDefaultError(vc: self, message: error.localizedDescription, okAction: { [unowned self] _ in
          self.navigationController?.popViewController(animated: true)
        })
      } else {
        guard let leaders = leaders else { return }
        self.userRecords = leaders
        self.tableView.reloadData()
      }
    }
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return userRecords.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "LeaderBoardCell", for: indexPath) as? LeaderBoardCell else {
      fatalError("Dequeued cell is not an instance of LeaderBoardCell!")
    }
   return cell.configureCell(with: userRecords[indexPath.row])
  }
}


