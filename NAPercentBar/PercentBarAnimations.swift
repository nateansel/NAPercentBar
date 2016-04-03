//
//  PercentBarAnimations.swift
//  NAPercentBar
//
//  Created by Nathan Ansel on 2/26/16.
//  Copyright © 2016 Nathan Ansel. All rights reserved.
//

import UIKit

extension PercentBar {
  /// Animates the percentView its full width with defined presets and a spring.
  ///   The duration is set to 0.3 seconds, the delay is set to 0, a 
  ///   springDampining of 0.5, no initialSpringVelocity, and no options or
  ///   completion blocks are used.
  ///
  /// - author: Nathan Ansel
  ///
  public func springAnimateToFullWidth() {
    springAnimateToFullWidth(
      duration:              0.3,
      delay:                 0,
      springDamping:         0.5,
      initialSpringVelocity: 0,
      options:               nil,
      completion:            nil)
  }
  
  /// Animates the percentView to its full width with spring.
  ///
  /// - author: Nathan Ansel
  ///
  /// - parameters:
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
  public func springAnimateToFullWidth(duration duration: NSTimeInterval, delay: NSTimeInterval, springDamping: CGFloat, initialSpringVelocity: CGFloat, options: UIViewAnimationOptions?, completion: ((Bool) -> ())?) {
    let fullWidth = frame.size.width * (percent ?? 0 / 100)
    UIView.animateWithDuration(duration,
      delay:                  delay,
      usingSpringWithDamping: springDamping,
      initialSpringVelocity:  initialSpringVelocity,
      options:                options ?? UIViewAnimationOptions.CurveEaseInOut,
      animations: {
        self.percentView?.frame.size.width = fullWidth
      },
      completion: { (finished: Bool) -> Void in
        completion?(finished)
      })
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
  public func animateToFullWidth(newPercent newPercent: CGFloat) {
    percent = newPercent
    animateToFullWidth()
  }
  
  /// Animates the percentView to its new percent. This is a simple ease in ease
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
  public func animateToFullWidth(newPercent newPercent: CGFloat, duration: NSTimeInterval, delay: NSTimeInterval, options: UIViewAnimationOptions?, completion: ((Bool) -> ())?) {
    percent = newPercent
    animateToFullWidth(
      duration:   duration,
      delay:      delay,
      options:    options,
      completion: completion)
  }
  
  /// Animates the percentView to its full width with defined presets.
  ///   The duration is set to 0.3 seconds, the delay is set to 0, and no
  ///   options or completion blocks are used.
  ///
  /// - author: Nathan Ansel
  ///
  public func animateToFullWidth() {
    animateToFullWidth(
      duration:   0.3,
      delay:      0,
      options:    nil,
      completion: nil)
  }
  
  /// Animates the percentView to its full width. This is a simple ease in ease
  ///   out animation.
  ///
  /// - author: Nathan Ansel
  ///
  /// - parameters:
  ///   - duration: The length of the animation in seconds.
  ///   - delay: The length of the delay before the animation starts, in seconds.
  ///   - options: How you would like the animation to be performed.
  ///   - completion: A block of code to run after the animation is completed.
  ///                 This block returns nothing and takes in one boolean
  ///                 arguement that tells if the animation completed successfully.
  ///
  public func animateToFullWidth(duration duration: NSTimeInterval, delay: NSTimeInterval, options: UIViewAnimationOptions?, completion: ((Bool) -> ())?) {
    springAnimateToFullWidth(
      duration:              duration,
      delay:                 delay,
      springDamping:         1,
      initialSpringVelocity: 0,
      options:               options,
      completion:            completion)
  }
  
  /// Instantly makes the width of percentView zero. No animations are performed.
  ///
  /// - author: Nathan Ansel
  ///
  public func snapToFullWidth() {
    percentView?.frame.size.width = frame.size.width * (percent ?? 0 / 100)
  }
}

extension PercentBar {
  /// Animates the percentView to a width of zero with defined presets.
  ///   The duration is set to 0.3 seconds, the delay is set to 0, and no
  ///   options or completion blocks are used.
  ///
  /// - author: Nathan Ansel
  ///
  public func animateToZeroWidth() {
    animateToZeroWidth(
      duration:   0.3,
      delay:      0,
      options:    nil,
      completion: nil)
  }
  
  /// Animates the percentView to a width of zero.
  ///
  /// - author: Nathan Ansel
  ///
  /// - parameters:
  ///   - duration: The length of the animation in seconds.
  ///   - delay: The length of the delay before the animation starts, in seconds.
  ///   - options: How you would like the animation to be performed.
  ///   - completion: A block of code to run after the animation is completed.
  ///                 This block returns nothing and takes in one boolean
  ///                 arguement that tells if the animation completed successfully.
  ///
  public func animateToZeroWidth(duration duration: NSTimeInterval, delay: NSTimeInterval, options: UIViewAnimationOptions?, completion: ((Bool) -> ())?) {
    UIView.animateWithDuration(duration,
      delay:      delay,
      options:    options ?? UIViewAnimationOptions.CurveEaseInOut,
      animations: {
        self.percentView?.frame.size.width = 0
      }) { (finished: Bool) -> Void in
        completion?(finished)
    }
  }
  
  /// Instantly makes the width of percentView zero. No animations are performed.
  ///
  /// - author: Nathan Ansel
  ///
  public func snapToZeroWidth() {
    percentView?.frame.size.width = 0
  }
}
