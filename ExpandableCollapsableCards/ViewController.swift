//
//  ViewController.swift
//  ExpandableCollapsableCards
//
//  Created by Sanchit Goel on 08/10/20.
//  Copyright © 2020 Sanchit Goel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  // MARK: - Variables
  var topSpacingForView: CGFloat = 110.0
  
  // MARK: - Lifecycle Methods
  override func viewDidLoad() {
    super.viewDidLoad()
    addExpandableCollapsableViews()
  }
  
  func addExpandableCollapsableViews() {
    // Create an array of custom cards
    var customCards = [ExpandableCollapsableCard]()
    
    // Set the frame of cards
    let cardFrame = CGRect(x: 0,
                       y: 0,
                       width: self.view.frame.width,
                       height: self.view.frame.height - topSpacingForView)
        
    // Create different custom cards as per requirement
    let firstView = FirstCardView(frame: cardFrame)
    let secondView = SecondCardView(frame: cardFrame)
    let thirdView = ThirdCardView(frame: cardFrame)
    
    // Append cards to custom cards array
    customCards.append(contentsOf: [firstView, secondView, thirdView])
    
    // Set the frame for the container of views
    let expandableViewFrame = CGRect(x: 0,
                                     y: 110,
                                     width: self.view.frame.width,
                                     height: self.view.frame.height - topSpacingForView)
        
    // Create the expandableCollapsable view with custom views
    let expandableCollapsableView = ExpandableCollapsableView(cardViews: customCards,
                                                              frame: expandableViewFrame)
    
    // Set the delegate of custom views as expandableCollapsableView
    firstView.delegate = expandableCollapsableView
    secondView.delegate = expandableCollapsableView
    thirdView.delegate = expandableCollapsableView
    
    // Add the view to controller and setup constraints
    self.view.addSubview(expandableCollapsableView)
    expandableCollapsableView.translatesAutoresizingMaskIntoConstraints = false
    
    expandableCollapsableView.leadingAnchor
      .constraint(equalTo: self.view.leadingAnchor).isActive = true
    expandableCollapsableView.topAnchor
      .constraint(equalTo: self.view.topAnchor, constant: topSpacingForView).isActive = true
    expandableCollapsableView.trailingAnchor
      .constraint(equalTo: self.view.trailingAnchor).isActive = true
    expandableCollapsableView.bottomAnchor
      .constraint(equalTo: self.view.bottomAnchor).isActive = true
  }
}
