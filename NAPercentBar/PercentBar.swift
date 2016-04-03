//
//  PercentBar.swift
//  NAPercentBar
//
//  Created by Nathan Ansel on 2/19/16.
//  Copyright © 2016 Nathan Ansel. All rights reserved.
//

import UIKit

/// A highly customizable percent bar. Contains a secondary view that shows the
///   percent, with two optional labels that reside inside, one on the left and
///   one on the right.
///
/// - author: Nathan Ansel
///
/// - version: 0.1
/// - todo: lots of stuff! Haha 😜
///
public class PercentBar: UIView {
  // MARK: - Properties
  
  // MARK: Standard
  
  public var percent:        CGFloat?
  public var color:          UIColor?
  public var leftLabelText:  String?
  public var rightLabelText: String?
  
  // MARK: - Subviews
  
  public var percentView:     UIView?  = UIView()
  internal var leftWhiteLabel:  UILabel? = UILabel()
  internal var leftColorLabel:  UILabel? = UILabel()
  internal var rightWhiteLabel: UILabel? = UILabel()
  internal var rightColorLabel: UILabel? = UILabel()
  
  // MARK: Border
  
  internal var borderWidth:  CGFloat?
  internal var cornerRadius: CGFloat?
  internal var borderColor:  CGColor?
  
  // MARK: Line Style
  
  internal var lineView:       UIView?
  internal var lineViewHeight: CGFloat? = 2
  internal var lineViewOffset: CGFloat? = 5
  
  // MARK: Placement
  
  /// The number of pixels the labels will be offset from the sides of the main
  ///   view.
  internal var labelOffset: CGFloat? = 5
  
  // MARK: Style
  
  public var style: NAPercentBarStyle? {
    didSet {
      if let style = style {
        setStyle(style)
      }
    }
  }
  
  public var styleAttributes: [NAPercentBarStyleAttributes]? {
    didSet {
      if let styleAttributes = styleAttributes {
        setStyleAttributes(styleAttributes)
      }
    }
  }
  
  // MARK: - Custom inits
  
  public convenience init(frame: CGRect, color: UIColor?, percent: CGFloat?, style: NAPercentBarStyle?) {
    self.init(
      frame:           frame,
      color:           color,
      percent:         percent,
      leftLabelText:   nil,
      rightLabelText:  nil,
      style:           style,
      styleAttributes: nil)
  }
  
  public convenience init(frame: CGRect, color: UIColor?, percent: CGFloat?, leftLabelText: String?, rightLabelText: String?, style: NAPercentBarStyle?, styleAttributes: [NAPercentBarStyleAttributes]?) {
    self.init(frame: frame)
    
    // Set property values
    self.percent         = percent
    self.color           = color
    self.style           = style
    self.styleAttributes = styleAttributes
    self.leftLabelText   = leftLabelText
    self.rightLabelText  = rightLabelText
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    clipsToBounds = true
    labelOffset   = CGFloat(10)
    
    // Set the views and labels to default views and labels, to be set up later.
    percentView     = UIView()
    leftColorLabel  = UILabel()
    leftWhiteLabel  = UILabel()
    rightColorLabel = UILabel()
    rightWhiteLabel = UILabel()
    
    // Add the white labels to the percentView
    if let leftWhiteLabel = leftWhiteLabel {
      percentView?.addSubview(leftWhiteLabel)
    }
    if let rightWhiteLabel = rightWhiteLabel {
      percentView?.addSubview(rightWhiteLabel)
    }
    
    // Add the color labels to the main view
    if let leftColorLabel = leftColorLabel {
      addSubview(leftColorLabel)
    }
    if let rightColorLabel = rightColorLabel {
      addSubview(rightColorLabel)
    }
    
    // Add percentView to the main view
    if let percentView = percentView {
      addSubview(percentView)
    }
  }
  
  required public init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
//    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Drawing
  
  // An override on layoutSubviews(), to see when this function will be called,
  //   look at this reference:
  //     [StackOverflow Question](http://stackoverflow.com/questions/728372/when-is-layoutsubviews-called)
  //   & [Logic High Blog](http://blog.logichigh.com/2011/03/16/when-does-layoutsubviews-get-called/)
  //
  override public func layoutSubviews() {
    super.layoutSubviews()
    
    setupBorders()
    setupPercentView()
    setupLabels()
  }
  
  private func setupBorders() {
    layer.borderColor = borderColor
  }
  
  /// Uses the properties that are set in the main view to set up the percentView.
  ///   Only called in layoutSubviews() for now, but can be called anytime when
  ///   in need of setting up the percentView.
  ///
  /// - author: Nathan Ansel
  ///
  private func setupPercentView() {
    // Only execute the code if percent exists, otherwise don't do anything.
    //   Nothing should be initialized when there is no percent value.
    if let percent = percent {
      let percentViewWidth = frame.size.width * (percent / 100)
      percentView?.frame = CGRect(x: 0, y: 0, width: percentViewWidth, height: frame.size.height)
      percentView?.backgroundColor = color
      if let cornerRadius = cornerRadius {
        percentView?.layer.cornerRadius = cornerRadius
      }
    }
    // Even if percent does not exist, still clip the subviews to the bounds of
    //   percentView.
    percentView?.clipsToBounds = true
  }
  
  /// Uses the properties that are set in the main view to set up the left and
  ///   right labels. Only called in layoutSubviews() for now, but can be called
  ///   anytime when in need of setting up the percentView.
  ///
  /// - author: Nathan Ansel
  ///
  private func setupLabels() {
    // Only execute this code if the left label text and both left labels are
    //   not nil.
    if let leftLabelText = leftLabelText, leftColorLabel = leftColorLabel, leftWhiteLabel = leftWhiteLabel {
      leftColorLabel.text = leftLabelText
      leftWhiteLabel.text = leftLabelText
      
      leftColorLabel.textColor = color
      leftWhiteLabel.textColor = UIColor.whiteColor()
      
      leftColorLabel.sizeToFit()
      leftWhiteLabel.sizeToFit()
      
      leftColorLabel.center = CGPoint(
        x: (labelOffset ?? 0) + (leftColorLabel.frame.size.width / 2),
        y: (frame.size.height / 2))
      leftWhiteLabel.center = leftColorLabel.center
    }
    
    // Only execute this code if the right label text and both right labels are
    //   not nil.
    if let rightLabelText = rightLabelText, rightColorLabel = rightColorLabel, rightWhiteLabel = rightWhiteLabel {
      rightColorLabel.text = rightLabelText
      rightWhiteLabel.text = rightLabelText
      
      rightColorLabel.textColor = color
      rightWhiteLabel.textColor = UIColor.whiteColor()
      
      rightColorLabel.sizeToFit()
      rightWhiteLabel.sizeToFit()
      
      rightColorLabel.center = CGPoint(
        x: (frame.size.width) - ((rightColorLabel.frame.size.width / 2) + (labelOffset ?? 0)),
        y: frame.size.height / 2)
      rightWhiteLabel.center = rightColorLabel.center
    }
  }
}
