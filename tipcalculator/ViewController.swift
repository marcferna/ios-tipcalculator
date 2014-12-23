//
//  ViewController.swift
//  tipcalculator
//
//  Created by Marc Fernandez on 12/14/14.
//  Copyright (c) 2014 Marc Fernandez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var amountField: UITextField!
  @IBOutlet weak var tipLabel: UILabel!
  @IBOutlet weak var totalLabel: UILabel!
  @IBOutlet weak var tipSegmentedControl: UISegmentedControl!
  
  var tipPercentages = [0.15, 0.18, 0.2, 0.22, 0.25];
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    tipLabel.text = "$0.00"
    totalLabel.text = "$0.00"
    
    setupTipSegmentedControl()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func setupTipSegmentedControl() {
    tipSegmentedControl.removeAllSegments()
    for var index = 0; index < tipPercentages.count; ++index {
      var tipPercentage = tipPercentages[index] * 100
      tipSegmentedControl.insertSegmentWithTitle("\(Int(tipPercentage))%",
        atIndex: index,
        animated: false
      )
    }
  }
  
  func tipPercentageFromControl() -> Double {
    var tipPercentage = 0.0
    var selectedIndex = tipSegmentedControl.selectedSegmentIndex
    if (selectedIndex >= 0 && selectedIndex < tipPercentages.count) {
      tipPercentage = tipPercentages[selectedIndex]
    }
    return tipPercentage
  }

  @IBAction func onEditingChanged(sender: AnyObject) {
    var tipPercentage = tipPercentageFromControl()
    var billAmount = amountField.text._bridgeToObjectiveC().doubleValue
    var tip = billAmount * tipPercentage
    var total = billAmount + tip
    
    tipLabel.text = String(format: "$%.2f", tip)
    totalLabel.text = String(format: "$%.2f", total)
  }

  @IBAction func onTap(sender: AnyObject) {
    view.endEditing(true)
  }
}

