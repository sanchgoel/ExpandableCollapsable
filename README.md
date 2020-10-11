# Expandable Collapsable
This project allows you to create stackable cards with expanding collapsing animation

## Installation Instructions
Cocopods Setup to integrate Expandable Collapsable into your Xcode project using CocoaPods, specify it in your Podfile:

`source 'https://github.com/sanchgoel/ExpandableCollapsablePodSpecs.git'`
`pod 'ExpandableCollapsable'`

## How to use
Sample usage with default values

Create Card views by subclassing ExpandableCollapsableCard.
For sample usage checkout card view files [here](https://github.com/sanchgoel/ExpandableCollapsable/tree/master/ExpandableCollapsableCards/CardViews)

Override this method in card view to reset state of cards on collapsing
```swift
override func resetCardState() {
  // do reset setup here
}
```

Modify and add this method to create ExpandableCollapsableView.
```swift
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
  guard let expandableCollapsableView = ExpandableCollapsableView(cardViews: customCards,
                                                                  frame: expandableViewFrame) else { return }
  
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
```
