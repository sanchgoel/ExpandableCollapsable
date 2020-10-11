//
//  PlanCollectionViewCell.swift
//  ExpandableCollapsableCards
//
//  Created by Sanchit Goel on 10/10/20.
//  Copyright © 2020 Sanchit Goel. All rights reserved.
//

import UIKit

class PlanCollectionViewCell: UICollectionViewCell {

  // MARK: - IBOutlets
  
  @IBOutlet weak var planContentView: UIView!
  @IBOutlet weak var amountLabel: UILabel!
  @IBOutlet weak var durationLabel: UILabel!  
  @IBOutlet weak var seeCalculationsLabel: UILabel!
  @IBOutlet weak var perMonthLabel: UILabel!
  
  func setupCell(plan: PlanType) {
    planContentView.backgroundColor = plan.cardColor
    amountLabel.text = "₹ \(plan.cost)"
    durationLabel.textColor = plan.textLightColor
    durationLabel.text = "for \(plan.durationInMonths) months"
    seeCalculationsLabel.textColor = plan.textDarkColor    
    perMonthLabel.textColor = plan.textDarkColor
  }
}
