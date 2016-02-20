//
//  PercentBar.swift
//  NAPercentBar
//
//  Created by Nathan Ansel on 2/19/16.
//  Copyright © 2016 Nathan Ansel. All rights reserved.
//

import UIKit

class PercentBar: UIView {
  
  // MARK: Properties
  
  var percent:         CGFloat?
  var percentView:     UIView?
  var color:           UIColor?
  var leftWhiteLabel:  UILabel?
  var leftColorLabel:  UILabel?
  var rightWhiteLabel: UILabel?
  var rightColorLabel: UILabel?
  
  var style: NAPercentBarStyle? {
    didSet {
      if let style = style {
        setStyle(style)
      }
    }
  }
  var styleAttributes: [NAPercentBarStyleAttributes]? {
    didSet {
      if let styleAttributes = styleAttributes {
        setStyleAttributes(styleAttributes)
      }
    }
  }
  
  // MARK: Custom inits
  
  convenience init(frame: CGRect, color: UIColor?, percent: CGFloat?) {
    self.init(
      frame:           frame,
      color:           color,
      percent:         percent,
      leftLabelText:   nil,
      rightLabelText:  nil,
      style:           nil,
      styleAttributes: nil)
  }
  
  convenience init(frame: CGRect, color: UIColor?, percent: CGFloat?, leftLabelText: String?, rightLabelText: String?, style: NAPercentBarStyle?, styleAttributes: [NAPercentBarStyleAttributes]?) {
    self.init(frame: frame)
    
    // Set property values
    self.percent         = percent
    self.color           = color
    self.style           = style
    self.styleAttributes = styleAttributes
  }
  
  override func layoutSubviews() {
    return
  }
    
}
