//
//  Style&Attributes.swift
//  NAPercentBar
//
//  Created by Nathan Ansel on 2/19/16.
//  Copyright © 2016 Nathan Ansel. All rights reserved.
//

import Foundation

/// A definition of the different styles of percent bars avalible in
///   NAPercentBar.
///
/// - author: Nathan Ansel
///
/// - todo: Add more styles
///
enum NAPercentBarStyle: String {
  /// A rounded bar with the percentage marked inside the bar with a
  ///   colored view the size of the percent of the original view.
  case Normal
  
  /// A simple line that spans the length of the percent of the whole view.
  case Line
}

/// Used to define the visual attributes that a percent bar will have.
///
/// - author: Nathan Ansel
///
/// - todo: Add more attributes
///
enum NAPercentBarStyleAttributes: String {
  /// Add a border to the main view.
  case Border
  
  /// Do not add a border to the main view. Overrides any presets by
  ///   NAPercentBarStyle.
  case NoBorder
  
  /// Make the text of the labels when outside of the percent view in the
  ///   percent bar the same color as the color attribute of the percent bar.
  case ColorLabels
  
  /// Make the text of the labels when outside of the percent view in the
  ///   percent bar black.
  case BlackLabels
}