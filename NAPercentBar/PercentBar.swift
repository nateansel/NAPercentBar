//
//  BasePercentView.swift
//  NAPercentBar
//
//  Created by Nathan Ansel on 5/3/16.
//  Copyright © 2016 Nathan Ansel. All rights reserved.
//

import UIKit

public class PercentBar: UIView {
  
  // MARK: - Public Properties
  
  /// The percent that the bar will display. The excepted values range from 0.0
  ///   to 1.0.
  ///
  ///   Updating this property will not make the bar update. Use any of the
  ///   animation or snapping functions provided to display the change.
  ///
  public var percent: CGFloat?
  
  /// The color to be used on both the percent bar and on the labels before the
  ///   percent bar covers them up.
  ///
  public var color: UIColor? {
    didSet {
      percentView.backgroundColor = color
      leftColorLabel.textColor    = color
      rightColorLabel.textColor   = color
      centerColorLabel.textColor  = color
      borderColor                 = color ?? UIColor.clearColor()
    }
  }
  
  /// The text to be displayed on the left side of the bar.
  ///
  public var leftLabelText: String? {
    didSet {
      leftWhiteLabel.text = leftLabelText
      leftColorLabel.text = leftLabelText
    }
  }
  
  /// The text to be displayed on the right side of the bar.
  ///
  public var rightLabelText: String? {
    didSet {
      rightWhiteLabel.text = rightLabelText
      rightColorLabel.text = rightLabelText
    }
  }
  
  /// The text to be displayed in the center of the bar.
  ///
  public var centerLabelText: String? {
    didSet {
      centerWhiteLabel.text = centerLabelText
      centerColorLabel.text = centerLabelText
    }
  }
  
  // MARK: - Internal Properties
  
  // MARK: Subviews
  
  internal var percentView:      UIView!
  internal var leftWhiteLabel:   UILabel!
  internal var leftColorLabel:   UILabel!
  internal var rightWhiteLabel:  UILabel!
  internal var rightColorLabel:  UILabel!
  internal var centerWhiteLabel: UILabel!
  internal var centerColorLabel: UILabel!
  
  // MARK: Border
  
  internal var borderWidth:  CGFloat = 1.0 {
    didSet {
      layer.borderWidth = borderWidth
    }
  }
  internal var cornerRadius: CGFloat = 0.0 {
    didSet {
      layer.cornerRadius = cornerRadius
      if (cornerRadius * 2) > percentView.frame.size.height {
        percentView.layer.cornerRadius = percentView.frame.size.height / 2
      }
      else {
        percentView.layer.cornerRadius = cornerRadius
      }
    }
  }
  internal var borderColor:  UIColor = UIColor.clearColor()
  
  // MARK: Line Style
  
//  internal var lineView:       UIView?
//  internal var lineViewHeight: CGFloat?
//  internal var lineViewOffset: CGFloat?
  
  // MARK: Placement
  
  /// The number of pixels the labels will be offset from the sides of the main
  ///   view.
  ///
  internal var labelOffset:                 CGFloat = 5
  internal var percentConstraint:           NSLayoutConstraint!
  internal var percentViewLeftConstraint:   NSLayoutConstraint!
  internal var percentViewTopConstraint:    NSLayoutConstraint!
  internal var percentViewBottomConstraint: NSLayoutConstraint!
  internal var percentViewInsets:           CGFloat = 0 {
    didSet {
      percentViewLeftConstraint?.constant   = percentViewInsets
      percentViewTopConstraint?.constant    = percentViewInsets
      percentViewBottomConstraint?.constant = -percentViewInsets
      layoutIfNeeded()
    }
  }
  
  // MARK: Size
  
  internal var fullWidth: CGFloat {
    if let widthHint = widthHint {
      return widthHint
    }
    return frame.size.width - (percentViewInsets * 2)
  }
  
  // TODO: Documentation
  public var widthHint: CGFloat?
  
  // MARK: Style
  
  // TODO: Documentation
  public var style: NAPercentBarStyle? {
    didSet {
      if let style = style {
        setStyle(style)
      }
    }
  }
  
  // TODO: Documentation
  public var styleAttributes: [NAPercentBarStyleAttributes]? {
    didSet {
      if let styleAttributes = styleAttributes {
        setStyleAttributes(styleAttributes)
      }
    }
  }

  // MARK: - Methods
  
  // MARK: Inits
  
  override public init(frame: CGRect) {
    super.init(frame: frame)
    
    setup()
  }
  
  required public init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
    setup()
  }
  
  /// Sets up the PercentBar class. Calls all the functions related to instatiating
  ///   subviews and creating constraints.
  ///
  private func setup() {
    createInternalViews()
    createConstraints()
    setupLabels()
  }
  
  public override func layoutSubviews() {
    cornerRadius = CGFloat(cornerRadius)
  }
  
  // MARK: Setting up the bar
  
  /// Creates all the internal views that live in this view.
  ///
  private func createInternalViews() {
    percentView      = UIView()
    leftWhiteLabel   = UILabel()
    leftColorLabel   = UILabel()
    rightWhiteLabel  = UILabel()
    rightColorLabel  = UILabel()
    centerWhiteLabel = UILabel()
    centerColorLabel = UILabel()
    
    percentView.addSubview(leftWhiteLabel)
    percentView.addSubview(rightWhiteLabel)
    percentView.addSubview(centerWhiteLabel)
    addSubview(percentView)
    insertSubview(leftColorLabel, belowSubview: percentView)
    insertSubview(rightColorLabel, belowSubview: percentView)
    insertSubview(centerColorLabel, belowSubview: percentView)
    
    layer.masksToBounds = true
    percentView.clipsToBounds = true
  }
  
  /// Sets `translatesAutoresizingMaskIntoConstraints` equal to false for every
  ///   view. This gets rid of auto-generated constraints.
  ///
  private func removeTranslatesMaskToConstraints() {
    translatesAutoresizingMaskIntoConstraints                  = false
    percentView.translatesAutoresizingMaskIntoConstraints      = false
    leftWhiteLabel.translatesAutoresizingMaskIntoConstraints   = false
    leftColorLabel.translatesAutoresizingMaskIntoConstraints   = false
    rightWhiteLabel.translatesAutoresizingMaskIntoConstraints  = false
    rightColorLabel.translatesAutoresizingMaskIntoConstraints  = false
    centerWhiteLabel.translatesAutoresizingMaskIntoConstraints = false
    centerColorLabel.translatesAutoresizingMaskIntoConstraints = false
  }
  
  /// Creates the constraints for the views.
  ///
  private func createConstraints() {
    removeTranslatesMaskToConstraints()
    
    percentViewLeftConstraint = NSLayoutConstraint(
      item: percentView,
      attribute: .Left,
      relatedBy: .Equal,
      toItem: self,
      attribute: .Left,
      multiplier: 1.0,
      constant: 0.0)
    percentViewLeftConstraint.active = true
    
    percentViewTopConstraint = NSLayoutConstraint(
      item: percentView,
      attribute: .Top,
      relatedBy: .Equal,
      toItem: self,
      attribute: .Top,
      multiplier: 1.0,
      constant: 0.0)
    percentViewTopConstraint.active = true
    
    percentViewBottomConstraint = NSLayoutConstraint(
      item: percentView,
      attribute: .Bottom,
      relatedBy: .Equal,
      toItem: self,
      attribute: .Bottom,
      multiplier: 1.0,
      constant: 0.0)
    percentViewBottomConstraint.active = true
    
    percentConstraint = NSLayoutConstraint(
      item: percentView,
      attribute: .Right,
      relatedBy: .Equal,
      toItem: percentView,
      attribute: .Left,
      multiplier: 1.0,
      constant: 0.0)
    percentConstraint.active = true
    
    leftWhiteLabel.leftAnchor.constraintEqualToAnchor(leftAnchor, constant: labelOffset).active = true
    leftWhiteLabel.centerYAnchor.constraintEqualToAnchor(centerYAnchor).active = true
    
    leftColorLabel.leftAnchor.constraintEqualToAnchor(leftWhiteLabel.leftAnchor).active = true
    leftColorLabel.centerYAnchor.constraintEqualToAnchor(leftWhiteLabel.centerYAnchor).active = true
    
    rightWhiteLabel.rightAnchor.constraintEqualToAnchor(rightAnchor, constant: -labelOffset).active = true
    rightWhiteLabel.centerYAnchor.constraintEqualToAnchor(centerYAnchor).active = true
    
    rightColorLabel.rightAnchor.constraintEqualToAnchor(rightWhiteLabel.rightAnchor).active = true
    rightColorLabel.centerYAnchor.constraintEqualToAnchor(rightWhiteLabel.centerYAnchor).active = true
    
    centerWhiteLabel.leftAnchor.constraintEqualToAnchor(leftAnchor).active = true
    centerWhiteLabel.rightAnchor.constraintEqualToAnchor(rightAnchor).active = true
    centerWhiteLabel.centerYAnchor.constraintEqualToAnchor(centerYAnchor).active = true
    
    centerColorLabel.leftAnchor.constraintEqualToAnchor(centerWhiteLabel.leftAnchor).active = true
    centerColorLabel.rightAnchor.constraintEqualToAnchor(centerWhiteLabel.rightAnchor).active = true
    centerColorLabel.centerYAnchor.constraintEqualToAnchor(centerWhiteLabel.centerYAnchor).active = true
  }
  
  private func setupLabels() {
    leftWhiteLabel.textColor   = UIColor.whiteColor()
    rightWhiteLabel.textColor  = UIColor.whiteColor()
    centerWhiteLabel.textColor = UIColor.whiteColor()
  }
}
