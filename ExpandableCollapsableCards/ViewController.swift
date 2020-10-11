//
//  ViewController.swift
//  ExpandableCollapsableCards
//
//  Created by Sanchit Goel on 08/10/20.
//  Copyright © 2020 Sanchit Goel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    addExpandableCollapsableViews()
  }
  
  func addExpandableCollapsableViews() {
    var customCards = [ExpandableCollapsableCard]()
    
    let frameToSet = CGRect(x: 0,
                            y: 120,
                            width: self.view.frame.width,
                            height: self.view.frame.height)
    
    let firstView = FirstCardView(frame: frameToSet)
    firstView.borderView.round(corners: [.topLeft, .topRight],
                                radius: 20.0)
    
    let secondView = SecondCardView(frame: frameToSet)
    secondView.borderView.round(corners: [.topLeft, .topRight],
                                 radius: 20.0)
    
    let thirdView = ThirdCardView(frame: frameToSet)
    thirdView.borderView.round(corners: [.topLeft, .topRight],
                               radius: 20.0)
    
    customCards.append(contentsOf: [firstView, secondView, thirdView])
        
    let expandableView = ExpandableCollapsableView(cardViews: customCards,
                                                   cardCTAs: [],
                                                   frame: frameToSet)
    
    firstView.delegate = expandableView
    secondView.delegate = expandableView
    thirdView.delegate = expandableView
    
    self.view.addSubview(expandableView)
    expandableView.translatesAutoresizingMaskIntoConstraints = false
    
    expandableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
    expandableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 120).isActive = true
    expandableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
    expandableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
  }
}
