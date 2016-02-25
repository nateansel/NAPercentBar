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
class PercentBar: UIView {
  // MARK: - Properties
  
  // MARK: Standard
  
  var percent:         CGFloat?
  var percentView:     UIView?
  var color:           UIColor?
  var leftWhiteLabel:  UILabel?
  var leftColorLabel:  UILabel?
  var rightWhiteLabel: UILabel?
  var rightColorLabel: UILabel?
  
  // MARK: Border
  
  internal var borderWidth:  CGFloat?
  internal var cornerRadius: CGFloat?
  internal var borderColor:  CGColor?
  
  // MARK: Style
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
  
  // MARK: - Custom inits
  
  convenience init(frame: CGRect, color: UIColor?, percent: CGFloat?) {
    self.init(
      frame:           frame,
      color:           color,
      percent:         percent,
      leftLabelText:   nil,
      rightLabelText:  nil,
      style:           .Normal,
      styleAttributes: nil)
  }
  
  convenience init(frame: CGRect, color: UIColor?, percent: CGFloat?, leftLabelText: String?, rightLabelText: String?, style: NAPercentBarStyle?, styleAttributes: [NAPercentBarStyleAttributes]?) {
    self.init(frame: frame)
    clipsToBounds = true
    
    // Set property values
    self.percent         = percent
    self.color           = color
    self.style           = style
    self.styleAttributes = styleAttributes
    
    // Set the views and labels to default views and labels, to be set up later.
    percentView          = UIView()
    leftColorLabel       = UILabel()
    leftWhiteLabel       = UILabel()
    rightColorLabel      = UILabel()
    rightWhiteLabel      = UILabel()
  }
  
  // MARK: - Drawing
  
  // An override on layoutSubviews(), to see when this function will be called,
  //   look at this reference:
  //     [StackOverflow Question](http://stackoverflow.com/questions/728372/when-is-layoutsubviews-called)
  //   & [Logic High Blog](http://blog.logichigh.com/2011/03/16/when-does-layoutsubviews-get-called/)
  //
  override func layoutSubviews() {
    super.layoutSubviews()
    
    // TODO: Actually layout the subviews in this method
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
}
