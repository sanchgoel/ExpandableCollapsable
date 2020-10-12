//
//  ExpandableCollapsableView.swift
//  ExpandableCollapsableCards
//
//  Created by Sanchit Goel on 09/10/20.
//  Copyright © 2020 Sanchit Goel. All rights reserved.
//

import UIKit

protocol ExpandableCollapsableDelegate: class {
  func cardDidTapped(view: ExpandableCollapsableCard)
  func showNextCard(view: ExpandableCollapsableCard)
}

class ExpandableCollapsableView: UIView {
  
  var cardViews: [ExpandableCollapsableCard]?
  var spaceBetweenCards: CGFloat = 110.0
  var cardTopConstraints = [NSLayoutConstraint]()
  
  init?(cardViews: [ExpandableCollapsableCard],
       frame: CGRect) {
    if cardViews.count < 2 {
      print("Error, expandable collapsable view requires a minimum of 2 views")
      return nil
    }
    if cardViews.count > 4 {
      print("Error, expandable collapsable view can have a maximum of 4 views")
      return nil
    }
    
    self.cardViews = cardViews
    super.init(frame: frame)
        
    setupView()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  func setupView() {
    guard let cardViews = cardViews else { return }
    for count in 0..<cardViews.count {
      let topSpace = CGFloat(count)*spaceBetweenCards
      addCard(view: cardViews[count],
              topSpace: topSpace)
    }
    self.backgroundColor = UIColor.clear
    setDefaultTopConstraintValues()
  }
  
  // Setup and add a new Card view
  func addCard(view: UIView, topSpace: CGFloat) {
    self.addSubview(view)
    view.translatesAutoresizingMaskIntoConstraints = false
    
    view.leadingAnchor
      .constraint(equalTo: self.leadingAnchor).isActive = true
    view.topAnchor
      .constraint(equalTo: self.topAnchor, constant: topSpace).isActive = true
    view.trailingAnchor
      .constraint(equalTo: self.trailingAnchor).isActive = true
    view.heightAnchor
      .constraint(equalTo: self.heightAnchor, constant: -topSpace).isActive = true
  }
  
  // Set default state i.e. the first card is expanded and rest are collapsed
  func setDefaultTopConstraintValues() {
    guard let cardView = cardViews?.first,
      let constraints = cardView.superview?.constraints
        .filter({ $0.firstAttribute == .top}) else { return }
    
    for index in 0..<constraints.count {
      if index == 0 {
        constraints[index].constant = 0
      } else {
        constraints[index].constant = self.frame.height
      }
             
    }
    cardTopConstraints = constraints
    
    self.layoutIfNeeded()
  }
  
  func expandNextCard(view: ExpandableCollapsableCard) {
    guard let cardViews = cardViews,
      let index = cardViews.firstIndex(of: view) else { return }
    
    let indexOfNewCard = index + 1
    
    if indexOfNewCard >= cardViews.count {
      return
    }
    
    // Set top constraints for expdanded cards
    for count in 0...indexOfNewCard {
      cardTopConstraints[count].constant = CGFloat(count) * spaceBetweenCards
    }
    
    // Set top constraints for collapsed cards
    for count in (indexOfNewCard + 1)..<cardViews.count {
      cardTopConstraints[count].constant = self.frame.height
    }
    
    UIView.animate(withDuration: 0.5,
                   delay: 0.0,
                   options: .curveEaseInOut,
                   animations: {
                    self.layoutIfNeeded()
    }, completion: nil)
  }
  
  func expandCurrentCard(view: ExpandableCollapsableCard) {
    guard let cardViews = cardViews,
      let indexOfCard = cardViews.firstIndex(of: view) else { return }
            
    // Set top constraints for expdanded cards
    for count in 0...indexOfCard {
      cardTopConstraints[count].constant = CGFloat(count) * spaceBetweenCards
    }
        
    // Set top constraints for collapsed cards
    for count in (indexOfCard + 1)..<cardViews.count {
      cardTopConstraints[count].constant = self.frame.height
    }
    
    UIView.animate(withDuration: 0.5,
                   delay: 0.0,
                   options: .curveEaseInOut,
                   animations: {
                    self.layoutIfNeeded()
    }, completion: { _ in
      for count in (indexOfCard + 1)..<cardViews.count {
        cardViews[count].resetCardState()
      }
    })
  }
}

extension ExpandableCollapsableView: ExpandableCollapsableDelegate {
  func cardDidTapped(view: ExpandableCollapsableCard) {
    self.expandCurrentCard(view: view)
  }
  
  func showNextCard(view: ExpandableCollapsableCard) {
    self.expandNextCard(view: view)
  }
}
