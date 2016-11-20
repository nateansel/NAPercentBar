//
//  ViewController.swift
//  NAPercentBarExample
//
//  Created by Nathan Ansel on 5/18/16.
//  Copyright © 2016 Nathan Ansel. All rights reserved.
//

import UIKit
import NAPercentBar

class ViewController: UIViewController {
  
  @IBOutlet weak var rectanglePercentBar:        PercentBarCG!
  @IBOutlet weak var roundedRectanglePercentBar: PercentBar!
  @IBOutlet weak var roundPercentBar:            PercentBar!

  override func viewDidLoad() {
    super.viewDidLoad()
    
    rectanglePercentBar.percent        = 0.0
    rectanglePercentBar.color          = UIColor.greenColor()
    rectanglePercentBar.leftLabelText  = "0%"
    rectanglePercentBar.rightLabelText = "100%"
//    rectanglePercentBar.style          = .Rectangle
//    rectanglePercentBar.styleAttributes = [.Border, .BlackLabels]
    
    roundedRectanglePercentBar.percent        = 0.0
    roundedRectanglePercentBar.color          = UIColor.purpleColor()
    roundedRectanglePercentBar.leftLabelText  = "Start"
    roundedRectanglePercentBar.rightLabelText = "End"
    roundedRectanglePercentBar.style          = .RoundedRectangle
    
    roundPercentBar.percent = 0.5
    roundPercentBar.color = UIColor.blueColor()
    roundPercentBar.leftLabelText = "0%"
    roundPercentBar.style = .InsetWithBorder
  }
  
  @IBAction func animateButtonPressedForRectangle(sender: UIButton) {
    if rectanglePercentBar.percent == 0.0 {
//      rectanglePercentBar.percent = 0.5
//      rectanglePercentBar.animateTo(newPercent: 0.5)
      rectanglePercentBar.springAnimateTo(newPercent: 0.5)
//      rectanglePercentBar.animateTo(newPercent: 0.5, duration: 0.8, completion: {
//        print(self.rectanglePercentBar.frame.size.width)
//      })
    }
    else {
      rectanglePercentBar.animateTo(newPercent: 0.0)
//      rectanglePercentBar.percent = 0.0
//      rectanglePercentBar.animateTo(newPercent: 0.0, duration: 0.8, completion: {
//        print(self.rectanglePercentBar.frame.size.width)
//      })
    }
  }
  
  @IBAction func animateButtonPressedForRoundedRectangle(sender: UIButton) {
    if roundedRectanglePercentBar.percent == 0.0 {
      roundedRectanglePercentBar.percent = 0.9
      roundedRectanglePercentBar.springAnimateToFullWidth(
        duration:              0.8,
        delay:                 0.0,
        springDamping:         0.5,
        initialSpringVelocity: 0.0,
        options:               .CurveEaseInOut,
        completion:            nil)
    }
    else {
      roundedRectanglePercentBar.percent = 0.0
      roundedRectanglePercentBar.animateToZeroWidth()
    }
  }
  
  @IBAction func animateButtonPressedForRound(sender: UIButton) {
    roundPercentBar.animateToFullWidth(
      newPercent: 0.75,
      duration:   0.5,
      delay:      0.0,
      options:    nil,
      completion: { (finished: Bool) in
        self.roundPercentBar.leftLabelText = "\(Int(self.roundPercentBar.percent! * 100))%"
        self.roundPercentBar.animateToFullWidth(
          newPercent: 0.35,
          duration:   0.5,
          delay:      0.5,
          options:    nil,
          completion: { (finished: Bool) in
            self.roundPercentBar.leftLabelText = "\(Int(self.roundPercentBar.percent! * 100))%"
        })
    })
  }
}

