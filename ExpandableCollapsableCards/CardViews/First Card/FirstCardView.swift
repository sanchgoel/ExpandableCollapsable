//
//  FirstCardView.swift
//  ExpandableCollapsableCards
//
//  Created by Sanchit Goel on 09/10/20.
//  Copyright © 2020 Sanchit Goel. All rights reserved.
//

import UIKit

class FirstCardView: ExpandableCollapsableCard {

  // MARK: - IBOutlets
  @IBOutlet var contentView: UIView!  
  @IBOutlet weak var borderView: UIView!
  @IBOutlet weak var expandedContentView: UIView!
  @IBOutlet weak var collapsedContentView: UIView!
  
  // MARK: - Variables
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
    Bundle.main.loadNibNamed("FirstCardView", owner: self, options: nil)
    addSubview(contentView)
    contentView.frame = self.bounds
    contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    
    setupUI()
  }
  
  func setupUI() {
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
