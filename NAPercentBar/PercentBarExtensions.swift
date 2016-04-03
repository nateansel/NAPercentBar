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
        setNormalStyle()
      case NAPercentBarStyle.Detail:
        setDetailStyle()
      case NAPercentBarStyle.Line:
        setLineStyle()
      default:
        print("This style has not been accounted for in setStyle(). The style has not been set."
              + "\nStyle: \(style.rawValue)")
    }
  }
  
  /// A function private to this file that sets up the Normal style. Removes the
  ///   lineView (if set), sets it to nil, and adds a border to the view.
  private func setNormalStyle() {
    borderWidth     = 1
    borderColor     = color?.CGColor
    cornerRadius    = frame.size.height / 2
    lineView?.removeFromSuperview()
    lineView        = nil
    leftLabelText   = nil
    rightLabelText  = nil
    styleAttributes = [.Border]
  }
  
  private func setDetailStyle() {
    borderWidth     = 1
    borderColor     = color?.CGColor
    cornerRadius    = 5
    lineView?.removeFromSuperview()
    lineView        = nil
    styleAttributes = [.Border, .ColorLabels]
    layoutIfNeeded()
  }
  
  /// A function private to this file that sets up the Line style. Sets up and
  ///   adds the line view to the main view.
  private func setLineStyle() {
    let X      = frame.size.width * ((percent ?? 0) / 100) + (lineViewOffset ?? 0)
    let Y      = frame.size.height - (lineViewHeight ?? 0)
    let width  = frame.size.width * ((100 - (percent ?? 0)) / 100) - (lineViewOffset ?? 0)
    let height = lineViewHeight ?? 0
    lineView = UIView(frame: CGRect(x: X, y: Y, width: width, height: height))
    // TODO: Needs to be completed.
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
          print("This attribute has not been accounted for in setStyleAttributes(), the attribute has not been set."
                + "\nAttribute: \(styleAttribute.rawValue)")
      }
    }
  }
  
  /// A function private to this file that adds the border to the main view.
  ///   If any of the values borderWidth, cornerRadius, & borderColor are not
  ///   set, this function replaces them with a 0. This could remove the border
  ///   if none of them are set, so make sure all of the values are set **before**
  ///   running this function.
  private func setAttributeBorder() {
    layer.borderWidth  = borderWidth ?? 0
    layer.cornerRadius = cornerRadius ?? 0
    layer.borderColor  = borderColor
  }
  
  /// A function private to this file that removes the border of the main view.
  private func setAttributeNoBorder() {
    layer.borderWidth  = 0
    layer.borderColor  = nil
    layer.cornerRadius = cornerRadius ?? 0
  }
  
  /// A function private to this file that sets the color of the colorLabels of
  ///   this percent bar to the color of the percent view.
  private func setAttributeColorLabels() {
    leftColorLabel?.textColor  = color
    rightColorLabel?.textColor = color
  }
  
  /// A function private to this file that sets the color of the colorLabels of
  ///   this percent bar to black.
  private func setAttributeBlackLabels() {
    leftColorLabel?.textColor  = UIColor.blackColor()
    rightColorLabel?.textColor = UIColor.blackColor()
  }
}