//
//  PercentBarCG.swift
//  NAPercentBar
//
//  Created by Nathan Ansel on 6/15/16.
//  Copyright © 2016 Nathan Ansel. All rights reserved.
//

import UIKit

public class PercentBarCG: UIView {
  
  // MARK: - Public Properties
  
  /// The percent that the bar will display. The excepted values range from 0.0
  ///   to 1.0.
  ///
  ///   Updating this property will not make the bar update. Use any of the
  ///   animation or snapping functions provided to display the change.
  ///
  public var percent: CGFloat {
    get {
      return _percent
    }
    set(newPercent) {
      snapTo(newPercent: newPercent)
    }
  }
  internal var _percent: CGFloat = 0.0
  
  /// The color to be used on both the percent bar and on the labels before the
  ///   percent bar covers them up.
  ///
  public var color: UIColor? {
    didSet {
      
    }
  }
  
  /// The text to be displayed on the left side of the bar.
  ///
  public var leftLabelText: String? {
    didSet {
      
    }
  }
  
  /// The text to be displayed on the right side of the bar.
  ///
  public var rightLabelText: String? {
    didSet {
      
    }
  }
  
  /// The text to be displayed in the center of the bar.
  ///
  public var centerLabelText: String? {
    didSet {
      
    }
  }
  
  // MARK: - Internal Properties
  
  internal var percentBar = CAShapeLayer()
//  private var left
  
  // MARK: Placement
  
  /// The number of pixels the labels will be offset from the sides of the main
  ///   view.
  ///
  internal var labelOffset:       CGFloat = 5
  internal var percentViewInsets: CGFloat = 0
  
  // MARK: Size
  
  internal var fullWidth: CGFloat {
    return frame.size.width - (percentViewInsets * 2)
  }
  internal var fullHeight: CGFloat {
    return frame.size.height - (percentViewInsets * 2)
  }
  internal var percentWidth: CGFloat {
    return fullWidth * percent
  }
  
  public override func drawRect(rect: CGRect) {
    let percentPath = UIBezierPath(rect: CGRect(
      x: percentViewInsets,
      y: percentViewInsets,
      width: percentWidth,
      height: fullHeight))
    percentBar.anchorPoint = CGPoint(x: percentViewInsets, y: percentViewInsets)
    percentBar.path = percentPath.CGPath
    percentBar.fillColor = color?.CGColor
    
    let leftText = NSString(string: leftLabelText!)
    
    layer.addSublayer(percentBar)
  }
}



//func drawText(rect:CGRect, ctx:CGContextRef, x:CGFloat, y:CGFloat, radius:CGFloat, sides:Int, color:UIColor) {
//  
//  // Flip text co-ordinate space, see: http://blog.spacemanlabs.com/2011/08/quick-tip-drawing-core-text-right-side-up/
//  CGContextTranslateCTM(ctx, 0.0, CGRectGetHeight(rect))
//  CGContextScaleCTM(ctx, 1.0, -1.0)
//  // dictates on how inset the ring of numbers will be
//  let inset:CGFloat = radius/3.5
//  // An adjustment of 270 degrees to position numbers correctly
//  let points = [CGPoint]()//circleCircumferencePoints(sides,x: x,y: y,radius: radius-inset,adjustment:270)
//  _ = CGPathCreateMutable()
//  // see
//  for p in points.enumerate() {
//    if p.index > 0 {
//      // Font name must be written exactly the same as the system stores it (some names are hyphenated, some aren't) and must exist on the user's device. Otherwise there will be a crash. (In real use checks and fallbacks would be created.) For a list of iOS 7 fonts see here: http://support.apple.com/en-us/ht5878
//      let aFont = UIFont(name: "DamascusBold", size: radius/5)
//      // create a dictionary of attributes to be applied to the string
//      let attr:CFDictionaryRef = [NSFontAttributeName:aFont!,NSForegroundColorAttributeName:UIColor.whiteColor()]
//      // create the attributed string
//      let text = CFAttributedStringCreate(nil, p.index.description, attr)
//      // create the line of text
//      let line = CTLineCreateWithAttributedString(text)
//      // retrieve the bounds of the text
//      let bounds = CTLineGetBoundsWithOptions(line, CTLineBoundsOptions.UseOpticalBounds)
//      // set the line width to stroke the text with
//      CGContextSetLineWidth(ctx, 1.5)
//      // set the drawing mode to stroke
//      CGContextSetTextDrawingMode(ctx, CGTextDrawingMode.FillStroke)
//      // Set text position and draw the line into the graphics context, text length and height is adjusted for
//      let xn = p.element.x - bounds.width/2
//      let yn = p.element.y - bounds.midY
//      CGContextSetTextPosition(ctx, xn, yn)
//      // the line of text is drawn - see https://developer.apple.com/library/ios/DOCUMENTATION/StringsTextFonts/Conceptual/CoreText_Programming/LayoutOperations/LayoutOperations.html
//      // draw the line of text
//      CTLineDraw(line, ctx)
//    }
//  }
//}
