//
//  PercentBarExtensions.swift
//  NAPercentBar
//
//  Created by Nathan Ansel on 2/19/16.
//  Copyright © 2016 Nathan Ansel. All rights reserved.
//

import UIKit

extension PercentBar {
  /// Sets the style for this PercentBar.
  ///
  /// - parameter style: A NAPercentBarStyle to set up the PercentBar with.
  ///                    Style attributes will always override the style.
  ///
  /// - author: Nathan Ansel
  ///
  internal func setStyle(_ style: NAPercentBarStyle) {
    switch style {
      case .Rectangle:
        setRectangleStyle()
      case .RoundedRectangle:
        setRoundedRectangleStyle()
      case .Round:
        setRoundStyle()
      case .InsetWithBorder:
        setRoundStyle()
        setInsetWithBorderStyle()
//      default:
//        print("This style has not been accounted for in setStyle(). The style has not been set."
//              + "\nStyle: \(style.rawValue)")
    }
  }
  
  fileprivate func setRectangleStyle() {
    cornerRadius      = 0.0
    styleAttributes   = [.Border]
    percentViewInsets = 0.0
  }
  
  fileprivate func setRoundedRectangleStyle() {
    cornerRadius      = 8.0
    styleAttributes   = [.Border]
    percentViewInsets = 0.0
  }
  
  fileprivate func setRoundStyle() {
    cornerRadius      = frame.size.height / 2
    styleAttributes   = [.Border]
    percentViewInsets = 0.0
  }
  
  fileprivate func setInsetWithBorderStyle() {
    borderWidth       = 2.0
    styleAttributes   = [.Border]
    percentViewInsets = 4.0
  }
}

extension PercentBar {
  /// Sets the style attributes for this PercentBar.
  ///
  /// - parameter styleAttributes: A list of all the style attributes to set. An
  ///                              empty list will add no attributes to the object.
  ///
  /// - author: Nathan Ansel
  ///
  internal func setStyleAttributes(_ styleAttributes: [NAPercentBarStyleAttributes]) {
    for styleAttribute in styleAttributes {
      switch styleAttribute {
        case .Border:
          self.setAttributeBorder()
        case .NoBorder:
          self.setAttributeNoBorder()
        case .ColorLabels:
          self.setAttributeColorLabels()
        case .BlackLabels:
          self.setAttributeBlackLabels()
//        default:
//          print("This attribute has not been accounted for in setStyleAttributes(), the attribute has not been set."
//                + "\nAttribute: \(styleAttribute.rawValue)")
      }
    }
  }
  
  /// A function private to this file that adds the border to the main view.
  ///   If any of the values borderWidth, & borderColor are not
  ///   set, this function replaces them with a 0. This could remove the border
  ///   if none of them are set, so make sure all of the values are set **before**
  ///   running this function.
  fileprivate func setAttributeBorder() {
    layer.borderWidth  = borderWidth ?? 0
    layer.borderColor  = borderColor.cgColor
  }
  
  /// A function private to this file that removes the border of the main view.
  fileprivate func setAttributeNoBorder() {
    layer.borderWidth  = 0
    layer.borderColor  = nil
  }
  
  /// A function private to this file that sets the color of the colorLabels of
  ///   this percent bar to the color of the percent view.
  fileprivate func setAttributeColorLabels() {
    leftColorLabel?.textColor  = color
    rightColorLabel?.textColor = color
  }
  
  /// A function private to this file that sets the color of the colorLabels of
  ///   this percent bar to black.
  fileprivate func setAttributeBlackLabels() {
    leftColorLabel?.textColor  = UIColor.black
    rightColorLabel?.textColor = UIColor.black
  }
}
