//
//  SecondCardView.swift
//  ExpandableCollapsableCards
//
//  Created by Sanchit Goel on 10/10/20.
//  Copyright © 2020 Sanchit Goel. All rights reserved.
//

import UIKit

class SecondCardView: ExpandableCollapsableCard {
  
  // MARK: - IBOutlets
  @IBOutlet var contentView: UIView!
  @IBOutlet var planCollectionView: UICollectionView!  
  @IBOutlet weak var borderView: UIView!
  @IBOutlet weak var expandedContentView: UIView!
  @IBOutlet weak var collapsedContentView: UIView!
  
  // MARK: - Variables
  var plans: [PlanType] = [PlanType(cost: "4,247",
                                    durationInMonths: 12,
                                    cardColor: UIColor(hex: "#47333F"),
                                    textDarkColor: UIColor(hex: "#7E6A76"),
                                    textLightColor: UIColor(hex: "#AB97A3")),
                           PlanType(cost: "5,580",
                                    durationInMonths: 9,
                                    cardColor: UIColor(hex: "#7E7292"),
                                    textDarkColor: UIColor(hex: "#ABA0BA"),
                                    textLightColor: UIColor(hex: "#C5BAD4")),
                           PlanType(cost: "8,230",
                                    durationInMonths: 6,
                                    cardColor: UIColor(hex: "#56698E"),
                                    textDarkColor: UIColor(hex: "#8798B6"),
                                    textLightColor: UIColor(hex: "#B4C8D9"))]
  
  weak var delegate: ExpandableCollapsableDelegate?
  
  // MARK: - Initializers
  override init(frame: CGRect) {
    super.init(frame: frame)
    commonInit()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    commonInit()
  }
  
  private func commonInit() {
    Bundle.main.loadNibNamed("SecondCardView", owner: self, options: nil)
    addSubview(contentView)
    contentView.frame = self.bounds
    contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
   
    setupUI()
  }
  
  func setupUI() {
    planCollectionView.delegate = self
    planCollectionView.dataSource = self
    let nib = UINib(nibName: "PlanCollectionViewCell", bundle: nil)
    self.planCollectionView.register(nib, forCellWithReuseIdentifier: "PlanCollectionViewCell")
    
    borderView.round(corners: [.topLeft, .topRight],
                     radius: 20.0,
                     frame: self.bounds)
    
    let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap))
    self.addGestureRecognizer(tap)
  }
  
  @objc func handleTap(_ sender: UITapGestureRecognizer?) {
    delegate?.cardDidTapped(view: self)
    animateExpandedState()
  }
  
  // MARK: - IBActions
  @IBAction func proceedBtnTapped(_ sender: Any) {
    delegate?.showNextCard(view: self)
    animateCollapsedState()
  }
  
  func animateExpandedState() {
    UIView.animate(withDuration: 0.3,
                   delay: 0.0,
                   options: .curveEaseInOut,
                   animations: {
                    self.expandedContentView.alpha = 1.0
                    self.collapsedContentView.alpha = 0.0
                    self.layoutIfNeeded()
    }, completion: nil)
  }
  
  func animateCollapsedState() {
    UIView.animate(withDuration: 0.3,
                   delay: 0.0,
                   options: .curveEaseInOut,
                   animations: {
                    self.expandedContentView.alpha = 0.0
                    self.collapsedContentView.alpha = 0.7
                    self.layoutIfNeeded()
    }, completion: nil)
  }
  
  override func resetCardState() {
    self.expandedContentView.alpha = 1.0
    self.collapsedContentView.alpha = 0.0
    self.layoutIfNeeded()
  }
}

// MARK: - Extensions
extension SecondCardView: UICollectionViewDelegate, UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView,
                      numberOfItemsInSection section: Int) -> Int {
    return plans.count
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView
      .dequeueReusableCell(withReuseIdentifier: "PlanCollectionViewCell",
                           for: indexPath) as? PlanCollectionViewCell else {
                            return UICollectionViewCell()
    }
    cell.setupCell(plan: self.plans[indexPath.item])
    return cell
  }
}
