//
//  SettingsViewController.swift
//  tipcalculator
//
//  Created by Marc Fernandez on 12/23/14.
//  Copyright (c) 2014 Marc Fernandez. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
  
  @IBOutlet weak var percentagePickerView: UIPickerView!
  @IBOutlet weak var closeButton: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupPickerView()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
    return 1
  }
  
  func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return Global.Constants.TipPercentages.count
  }
  
  func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
    return String(format: "%.0f%%", Global.Constants.TipPercentages[row] * 100.0)
  }
  
  func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    var defaults = NSUserDefaults.standardUserDefaults()
    defaults.setInteger(row, forKey: Global.Constants.KeyDefaultTipPercentageIndex)
    defaults.synchronize()
  }
  
  // Helper methods
  
  func setupPickerView() {
    var defaults = NSUserDefaults.standardUserDefaults()
    var percentageRow = defaults.objectForKey(Global.Constants.KeyDefaultTipPercentageIndex)?.integerValue
    if (percentageRow != nil) {
      percentagePickerView.selectRow(percentageRow!, inComponent: 0, animated: false)
    }
  }
  
  // IBActions
  
  @IBAction func onCloseTapped(sender: AnyObject) {
    self.dismissViewControllerAnimated(true, completion: nil)
  }

}
