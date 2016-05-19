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
  
  @IBOutlet weak var percentBar: NewPercentBar!
  
  var percent = CGFloat(0.00)

  override func viewDidLoad() {
    super.viewDidLoad()
    
    percentBar.percent = percent
    percentBar.color = UIColor.greenColor()
    percentBar.leftLabelText = "0%"
    percentBar.rightLabelText = "100%"
  }
  
  @IBAction func animateButtonPressed(sender: UIButton) {
    if percent == 0.0 {
      percent = 0.5
      percentBar.animateToFullWidth(newPercent: percent)
    }
    else {
      percent = 0.0
      percentBar.animateToFullWidth(newPercent: percent)
    }
  }
}

