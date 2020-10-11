//
//  Extensions.swift
//  ExpandableCollapsableCards
//
//  Created by Sanchit Goel on 09/10/20.
//  Copyright © 2020 Sanchit Goel. All rights reserved.
//

import UIKit

extension UIView {
  func round(corners: UIRectCorner, radius: CGFloat) {
    let path = UIBezierPath(roundedRect: bounds,
                            byRoundingCorners: corners,
                            cornerRadii: CGSize(width: radius, height: radius))
    let mask = CAShapeLayer()
    mask.path = path.cgPath
    layer.mask = mask
  }
  
  @IBInspectable
  var cRadius: CGFloat {
    get {
      return layer.cornerRadius
    }
    set {
      layer.cornerRadius = newValue
    }
  }
  
  @IBInspectable
  var bWidth: CGFloat {
    get {
      return layer.borderWidth
    }
    set {
      layer.borderWidth = newValue
    }
  }
  
  @IBInspectable
  var bColor: UIColor? {
    get {
      if let color = layer.borderColor {
        return UIColor(cgColor: color)
      }
      return nil
    }
    set {
      if let color = newValue {
        layer.borderColor = color.cgColor
      } else {
        layer.borderColor = nil
      }
    }
  }
  
  @IBInspectable
  var sRadius: CGFloat {
    get {
      return layer.shadowRadius
    }
    set {
      layer.shadowRadius = newValue
    }
  }
  
  @IBInspectable
  var sOpacity: Float {
    get {
      return layer.shadowOpacity
    }
    set {
      layer.shadowOpacity = newValue
    }
  }
  
  @IBInspectable
  var sOffset: CGSize {
    get {
      return layer.shadowOffset
    }
    set {
      layer.shadowOffset = newValue
    }
  }
  
  @IBInspectable
  var sColor: UIColor? {
    get {
      if let color = layer.shadowColor {
        return UIColor(cgColor: color)
      }
      return nil
    }
    set {
      if let color = newValue {
        layer.shadowColor = color.cgColor
      } else {
        layer.shadowColor = nil
      }
    }
  }
}

open class CustomLabel : UILabel {
  /*
   Handles Character Spacing in label text
   **/
  @IBInspectable open var characterSpacing:CGFloat = 1 {
    didSet {
      let attributedString = NSMutableAttributedString(string: self.text!)
      attributedString.addAttribute(.kern,
                                    value: self.characterSpacing,
                                    range: NSRange(location: 0, length: attributedString.length))
      self.attributedText = attributedString
    }
    
  }
}

open class CustomButton : UIButton {
  @IBInspectable open var characterSpacing: CGFloat = 1 {
    didSet {
      let attributedString = NSMutableAttributedString(string: self.titleLabel?.text ?? "")
      attributedString.addAttribute(.kern,
                                    value: self.characterSpacing,
                                    range: NSRange(location: 0,
                                                   length: attributedString.length))
      self.titleLabel?.attributedText = attributedString
    }
  }
}

extension UIColor {
  public convenience init?(hex: String) {
    var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
    
    if (cString.hasPrefix("#")) {
      cString.remove(at: cString.startIndex)
    }
    
    if ((cString.count) != 6) {
      self.init(red: 0, green: 0, blue: 0, alpha: 1.0)
    }
    
    var rgbValue:UInt64 = 0
    Scanner(string: cString).scanHexInt64(&rgbValue)
    
    let r = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
    let g = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
    let b = CGFloat(rgbValue & 0x0000FF) / 255.0
    let a = CGFloat(1.0)
    self.init(red: r, green: g, blue: b, alpha: a)
    return
  }
}
