//
//  ViewController.swift
//  WhatIsMyBMI
//
//  Created by Henrik Raitasola on 08/01/17.
//  Copyright © 2017 Henrik Raitasola. All rights reserved.
//

import UIKit
import Foundation

extension UISlider {
    var thumbCenterX: CGFloat {
        let _trackRect = trackRect(forBounds: self.bounds)
        let _thumbRect = thumbRect(forBounds: self.bounds, trackRect: _trackRect, value: value)
        return _thumbRect.midX + _thumbRect.width / 2
    }
}

class ViewController: UIViewController {
    @IBOutlet weak var heightSlider: UISlider!
    @IBOutlet weak var heightValue: UILabel!
    @IBOutlet weak var weightSlider: UISlider!
    @IBOutlet weak var weightValue: UILabel!
    var heightValueState: Int = 170
    var weightValueState: Int = 68
    @IBOutlet weak var bmiResult: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        heightValue.layer.masksToBounds = true
        heightValue.layer.cornerRadius = 15
        weightValue.layer.masksToBounds = true
        weightValue.layer.cornerRadius = 15
        updateBMI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func roundToOneDecimal(unrounded: Double) -> Double {
        return Double(round(10 * unrounded) / 10)
    }
    
    private func calculateBMI() -> Double {
        let heightInMeters = Double(heightValueState) / Double(100)
        let heightSquared = pow(heightInMeters, 2.0)
        let bmi = Double(weightValueState) / heightSquared
        return roundToOneDecimal(unrounded: bmi)
    }
    
    private func updateBMI() {
        bmiResult.text = String(calculateBMI())
    }

    @IBAction func onHeightChange(_ sender: Any) {
        heightValueState = Int(heightSlider.value)
        heightValue.text = "\(String(heightValueState)) cm"
        updateBMI()
        heightValue.center.x = heightSlider.thumbCenterX
    }

    @IBAction func onWeightChange(_ sender: Any) {
        weightValueState = Int(weightSlider.value)
        weightValue.text = "\(String(weightValueState)) kg"
        updateBMI()
        weightValue.center.x = weightSlider.thumbCenterX
    }
}

