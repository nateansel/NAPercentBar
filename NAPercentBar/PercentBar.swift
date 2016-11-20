//
//  BasePercentView.swift
//  NAPercentBar
//
//  Created by Nathan Ansel on 5/3/16.
//  Copyright © 2016 Nathan Ansel. All rights reserved.
//

import UIKit

open class PercentBar: UIView {
  
  // MARK: - Public Properties
  
  /// The percent that the bar will display. The excepted values range from 0.0
  ///   to 1.0.
  ///
  ///   Updating this property will not make the bar update. Use any of the
  ///   animation or snapping functions provided to display the change.
  ///
  open var percent: CGFloat?
  
  /// The color to be used on both the percent bar and on the labels before the
  ///   percent bar covers them up.
  ///
  open var color: UIColor? {
    didSet {
      percentView.backgroundColor = color
      leftColorLabel.textColor    = color
      rightColorLabel.textColor   = color
      centerColorLabel.textColor  = color
      borderColor                 = color ?? UIColor.clear
    }
  }
  
  /// The text to be displayed on the left side of the bar.
  ///
  open var leftLabelText: String? {
    didSet {
      leftWhiteLabel.text = leftLabelText
      leftColorLabel.text = leftLabelText
    }
  }
  
  /// The text to be displayed on the right side of the bar.
  ///
  open var rightLabelText: String? {
    didSet {
      rightWhiteLabel.text = rightLabelText
      rightColorLabel.text = rightLabelText
    }
  }
  
  /// The text to be displayed in the center of the bar.
  ///
  open var centerLabelText: String? {
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
  internal var borderColor:  UIColor = UIColor.clear
  
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
  open var widthHint: CGFloat?
  
  // MARK: Style
  
  // TODO: Documentation
  open var style: NAPercentBarStyle? {
    didSet {
      if let style = style {
        setStyle(style)
      }
    }
  }
  
  // TODO: Documentation
  open var styleAttributes: [NAPercentBarStyleAttributes]? {
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
  fileprivate func setup() {
    createInternalViews()
    createConstraints()
    setupLabels()
  }
  
  open override func layoutSubviews() {
    cornerRadius = CGFloat(cornerRadius)
  }
  
  // MARK: Setting up the bar
  
  /// Creates all the internal views that live in this view.
  ///
  fileprivate func createInternalViews() {
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
  fileprivate func removeTranslatesMaskToConstraints() {
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
  fileprivate func createConstraints() {
    removeTranslatesMaskToConstraints()
    
    percentViewLeftConstraint = NSLayoutConstraint(
      item: percentView,
      attribute: .left,
      relatedBy: .equal,
      toItem: self,
      attribute: .left,
      multiplier: 1.0,
      constant: 0.0)
    percentViewLeftConstraint.isActive = true
    
    percentViewTopConstraint = NSLayoutConstraint(
      item: percentView,
      attribute: .top,
      relatedBy: .equal,
      toItem: self,
      attribute: .top,
      multiplier: 1.0,
      constant: 0.0)
    percentViewTopConstraint.isActive = true
    
    percentViewBottomConstraint = NSLayoutConstraint(
      item: percentView,
      attribute: .bottom,
      relatedBy: .equal,
      toItem: self,
      attribute: .bottom,
      multiplier: 1.0,
      constant: 0.0)
    percentViewBottomConstraint.isActive = true
    
    percentConstraint = NSLayoutConstraint(
      item: percentView,
      attribute: .right,
      relatedBy: .equal,
      toItem: percentView,
      attribute: .left,
      multiplier: 1.0,
      constant: 0.0)
    percentConstraint.isActive = true
    
    leftWhiteLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: labelOffset).isActive = true
    leftWhiteLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    
    leftColorLabel.leftAnchor.constraint(equalTo: leftWhiteLabel.leftAnchor).isActive = true
    leftColorLabel.centerYAnchor.constraint(equalTo: leftWhiteLabel.centerYAnchor).isActive = true
    
    rightWhiteLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -labelOffset).isActive = true
    rightWhiteLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    
    rightColorLabel.rightAnchor.constraint(equalTo: rightWhiteLabel.rightAnchor).isActive = true
    rightColorLabel.centerYAnchor.constraint(equalTo: rightWhiteLabel.centerYAnchor).isActive = true
    
    centerWhiteLabel.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
    centerWhiteLabel.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
    centerWhiteLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    
    centerColorLabel.leftAnchor.constraint(equalTo: centerWhiteLabel.leftAnchor).isActive = true
    centerColorLabel.rightAnchor.constraint(equalTo: centerWhiteLabel.rightAnchor).isActive = true
    centerColorLabel.centerYAnchor.constraint(equalTo: centerWhiteLabel.centerYAnchor).isActive = true
  }
  
  fileprivate func setupLabels() {
    leftWhiteLabel.textColor   = UIColor.white
    rightWhiteLabel.textColor  = UIColor.white
    centerWhiteLabel.textColor = UIColor.white
  }
}
