//
//  ViewController.swift
//  WhatIsMyBMI
//
//  Created by Henrik Raitasola on 08/01/17.
//  Copyright © 2017 Henrik Raitasola. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {
    @IBOutlet weak var heightSlider: UISlider!
    @IBOutlet weak var heightValue: UILabel!
    @IBOutlet weak var weightSlider: UISlider!
    @IBOutlet weak var weightValue: UILabel!
    var heightValueState: Int?
    var weightValueState: Int?
    @IBOutlet weak var bmiResult: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func roundToString(sliderValue : Float) -> String {
        return String(Int(sliderValue))
    }
    
    private func calculateBMI(weight : Int, height : Int) -> Double {
        let heightInMeters = Double(height) / Double(100)
        let heightSquared = pow(heightInMeters, 2.0)
        let unRoundedBMI = Double(weight) / heightSquared
        return Double(round(10 * unRoundedBMI) / 10)
    }

    @IBAction func onHeightChange(_ sender: Any) {
        heightValueState = Int(heightSlider.value)
        heightValue.text = "\(roundToString(sliderValue: heightSlider.value)) cm"
    }

    @IBAction func onWeightChange(_ sender: Any) {
        weightValueState = Int(weightSlider.value)
        weightValue.text = "\(roundToString(sliderValue: weightSlider.value)) kg"
    }
    @IBAction func onCalculateButtonTap(_ sender: Any) {
        if heightValueState != nil && weightValueState != nil {
            let bmi = calculateBMI(weight: weightValueState!, height: heightValueState!)
            bmiResult.text = String(bmi)
        }
    }
}

