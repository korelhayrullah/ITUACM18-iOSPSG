//
//  LeaderBoardCell.swift
//  QuizifyApp
//
//  Created by Korel Hayrullah on 11.12.2018.
//  Copyright © 2018 Korel Hayrullah. All rights reserved.
//

import UIKit

class LeaderBoardCell: UITableViewCell {
  @IBOutlet weak var nameLbl: UILabel!
  @IBOutlet weak var rankLbl: UILabel!
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  func configureCell(with model: LeaderboardModel) -> LeaderBoardCell {
    nameLbl.text = model.username ?? "Anonymous player"
    rankLbl.text = "\(model.total_score)"
    return self
  }
}
