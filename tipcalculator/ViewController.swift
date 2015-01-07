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
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupLabels()
    setupTipSegmentedControl()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  override func viewWillAppear(animated: Bool) {
    setDefaultTipPercentage()
  }
  
  func setupLabels() {
    tipLabel.text   = "$0.00"
    totalLabel.text = "$0.00"
  }
  
  func setupTipSegmentedControl() {
    tipSegmentedControl.removeAllSegments()
    var tipPercentages = Global.Constants.TipPercentages;
    for var index = 0; index < tipPercentages.count; ++index {
      var tipPercentage = tipPercentages[index] * 100
      tipSegmentedControl.insertSegmentWithTitle("\(Int(tipPercentage))%",
        atIndex: index,
        animated: false
      )
    }
  }
  
  func setDefaultTipPercentage() {
    var defaults = NSUserDefaults.standardUserDefaults()
    var percentageRow = defaults.objectForKey(Global.Constants.KeyDefaultTipPercentageIndex)?.integerValue
    if (percentageRow != nil) {
      tipSegmentedControl.selectedSegmentIndex = percentageRow!
      onEditingChanged(amountField)
    }
  }
  
  func tipPercentageFromControl() -> Double {
    var tipPercentages = Global.Constants.TipPercentages;
    var tipPercentage = 0.0
    var selectedIndex = tipSegmentedControl.selectedSegmentIndex
    if (selectedIndex >= 0 && selectedIndex < tipPercentages.count) {
      tipPercentage = tipPercentages[selectedIndex]
    }
    return tipPercentage
  }

  // IBActions 
  
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

