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
  func setStyle(style: NAPercentBarStyle) {
    switch style {
      case NAPercentBarStyle.Normal:
        self.setNormalStyle()
      case NAPercentBarStyle.Line:
        self.setLineStyle()
    }
  }
  
  private func setNormalStyle() {
    // TODO: Write code to set a normal style
  }
  
  private func setLineStyle() {
    // TODO: Write code to set a line style
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
  func setStyleAttributes(styleAttributes: [NAPercentBarStyleAttributes]) {
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
        default:
          print("This attribute has not been accounted for in setStyleAttributes()")
      }
    }
  }
  
  /// An function private to this file that adds the border to the main view.
  ///   If any of the values borderWidth, cornerRadius, & borderColor are not
  ///   set, this function replaces them with a 0. This could remove the border
  ///   if none of them are set, so make sure all of the values are set **before**
  ///   running this function.
  private func setAttributeBorder() {
    layer.borderWidth  = borderWidth ?? 0
    layer.cornerRadius = cornerRadius ?? 0
    layer.borderColor  = borderColor
  }
  
  /// An function private to this file that removes the border of the main view.
  private func setAttributeNoBorder() {
    layer.borderWidth  = 0
    layer.borderColor  = nil
    layer.cornerRadius = cornerRadius ?? 0
  }
  
  /// An function private to this file that sets the color of the colorLabels of
  ///   this percent bar to the color of the percent view.
  private func setAttributeColorLabels() {
    leftColorLabel?.textColor  = color
    rightColorLabel?.textColor = color
  }
  
  /// An function private to this file that sets the color of the colorLabels of
  ///   this percent bar to black.
  private func setAttributeBlackLabels() {
    leftColorLabel?.textColor  = UIColor.blackColor()
    rightColorLabel?.textColor = UIColor.blackColor()
  }
}