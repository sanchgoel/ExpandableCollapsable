//
//  ThirdCard.swift
//  ExpandableCollapsableCards
//
//  Created by Sanchit Goel on 11/10/20.
//  Copyright © 2020 Sanchit Goel. All rights reserved.
//

import UIKit

class ThirdCardView: ExpandableCollapsableCard {
  
  // MARK: - IBOutlets
  @IBOutlet var contentView: UIView!
  @IBOutlet weak var borderView: UIView!
  
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
    Bundle.main.loadNibNamed("ThirdCardView", owner: self, options: nil)
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
  }
  
  // MARK: - IBActions
  @IBAction func proceedBtnTapped(_ sender: Any) {
    
  }
}
