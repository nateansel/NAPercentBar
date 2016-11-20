//
//  PercentBarCGAnimations.swift
//  NAPercentBar
//
//  Created by Nathan Ansel on 6/15/16.
//  Copyright © 2016 Nathan Ansel. All rights reserved.
//

import UIKit

// MARK: - To Full Width

extension PercentBarCG {
  /// Animates the percentView its full width with defined presets and a spring.
  ///   The duration is set to 0.3 seconds, the delay is set to 0, a
  ///   springDampining of 0.7, no initialSpringVelocity, and no options or
  ///   completion blocks are used.
  ///
  /// - author: Nathan Ansel
  ///
  /// - parameter newPercent: The new percent value that will be set for the bar
  ///                         and then animated to.
  ///
  public func springAnimateTo(newPercent newPercent: CGFloat) {
    springAnimateTo(
      newPercent:            newPercent,
      duration:              3.3,
      springDamping:         0.7,
      initialSpringVelocity: 0,
      completion:            nil)
  }
  
  /// Animates the percentView to its full width with spring.
  ///
  /// - author: Nathan Ansel
  ///
  /// - parameters:
  ///   - newPercent: The new percent value that will be set for the bar
  ///                         and then animated to.
  ///   - duration: The length of the animation in seconds
  ///   - delay: The length of the delay before the animation starts, in seconds
  ///   - springDampining: The amount of dampining to be used in a spring
  ///                      animation. More information about dampinging can be
  ///                      found [here](http://www.informit.com/articles/article.aspx?p=2217000)
  ///   - initialSpringVelocity: The amount of initial velocity the spring
  ///                            animation has.
  ///   - options: How the animation will be performed
  ///   - completion: A block of code to run after the animation is completed
  ///                 This block returns nothing and takes in one boolean
  ///                 arguement that tells if the animation completed successfully
  ///
  public func springAnimateTo(newPercent newPercent: CGFloat, duration: NSTimeInterval, springDamping: CGFloat, initialSpringVelocity: CGFloat, completion: (() -> ())?) {
    _percent = newPercent
//    var newBounds = percentBar.bounds
//    newBounds.size.width = percentWidth
//    percentBar.bounds = newBounds
    let newPath = UIBezierPath(rect: CGRect(
      x: percentViewInsets,
      y: percentViewInsets,
      width: percentWidth,
      height: fullHeight))
    
    let animation = CASpringAnimation(keyPath: "path")
    animation.damping = springDamping
    animation.initialVelocity = initialSpringVelocity
//    let animation = CABasicAnimation(keyPath: "path")
    animation.fromValue = percentBar.path!
    animation.toValue = newPath.CGPath
    animation.duration = Double(duration)
    animation.delegate = self
//    animation.removedOnCompletion = false
    animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
//    animation.fillMode = kCAFillModeBoth
    
    percentBar.addAnimation(animation, forKey: animation.keyPath)
    percentBar.path = newPath.CGPath
  }
  
  /// Animates the percentView to its new percent value. This is a simple ease
  ///   in ease out animation with defined presets. The duration is set to 0.3
  ///   seconds, the delay is set to 0, and no options or completion blocks are
  ///   used.
  ///
  /// - author: Nathan Ansel
  ///
  /// - parameter newPercent: The new percent value that will be set for the bar
  ///                         and then animated to.
  ///
  public func animateTo(newPercent newPercent: CGFloat) {
    animateTo(
      newPercent: newPercent,
      duration:   3.3,
      completion: nil)
  }
  
  /// Animates the percentView to its full width. This is a simple ease in ease
  ///   out animation.
  ///
  /// - author: Nathan Ansel
  ///
  /// - parameters:
  ///   - newPercent: The new percent value that will be set in for the bar and
  ///                 then animated to.
  ///   - duration: The length of the animation in seconds.
  ///   - delay: The length of the delay before the animation starts, in seconds.
  ///   - options: How you would like the animation to be performed.
  ///   - completion: A block of code to run after the animation is completed.
  ///                 This block returns nothing and takes in one boolean
  ///                 arguement that tells if the animation completed successfully.
  ///
  public func animateTo(newPercent newPercent: CGFloat, duration: NSTimeInterval, completion: (() -> ())?) {
    springAnimateTo(
      newPercent:            newPercent,
      duration:              duration,
      springDamping:         2.0,
      initialSpringVelocity: 0.0,
      completion:            completion)
  }
  
  /// Snaps the display to a new percent value.
  ///
  /// - parameter newPercent: The new percent value that will be set for the bar
  ///                         and then animated to.
  public func snapTo(newPercent newPercent: CGFloat) {
    _percent = newPercent
    setNeedsDisplay()
  }
}

extension PercentBarCG {
  public override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
    if flag {
      print(anim.description + "\nFINISHED")
    }
  }
}
