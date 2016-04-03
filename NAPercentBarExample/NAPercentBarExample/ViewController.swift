//
//  ViewController.swift
//  NAPercentBarExample
//
//  Created by Nathan Ansel on 3/28/16.
//  Copyright © 2016 Nathan Ansel. All rights reserved.
//

import UIKit
import NAPercentBar

class ViewController: UIViewController {

  @IBOutlet weak var NormalView: PercentBar!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    NormalView.percent = CGFloat(50.0)
    NormalView.color = UIColor.purpleColor()
    NormalView.leftLabelText = "0%"
    NormalView.rightLabelText = "100%"
    NormalView.style = .Normal
    NormalView.layoutSubviews()
    NormalView.animateToFullWidth()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  @IBAction func NormalButtonPressed(sender: AnyObject) {
    NormalView.animateToFullWidth(newPercent: CGFloat(100))
    print(NormalView.percent)
    print(NormalView.percentView)
  }

}

