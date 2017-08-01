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

class TriangleView : UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func draw(_ rect: CGRect) {
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        context.beginPath()
        context.move(to: CGPoint(x: rect.minX, y: rect.minY))
        context.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
        context.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        context.closePath()
        
        context.setFillColor(red: 255.0, green: 255.5, blue: 255.0, alpha: 0.4)
        context.fillPath()
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
    @IBOutlet weak var maleButton: UIButton!
    @IBOutlet weak var femaleButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        heightValue.clipsToBounds = false
        let heightTriangle = TriangleView(frame: CGRect(x: heightValue.bounds.midX - 7, y: heightValue.bounds.maxY, width: 14 , height: 5))
        heightTriangle.backgroundColor = UIColor(white: 1, alpha: 0.0)
        heightValue.addSubview(heightTriangle)
        
        weightValue.clipsToBounds = false
        let weightTriangle = TriangleView(frame: CGRect(x: weightValue.bounds.midX - 7, y: weightValue.bounds.maxY, width: 14 , height: 5))
        weightTriangle.backgroundColor = UIColor(white: 1, alpha: 0.0)
        weightValue.addSubview(weightTriangle)
        
        updateBMI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
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
    
    private func activateButton(button: UIButton) {
        let activeButton: UIButton = button == maleButton ? maleButton : femaleButton
        let disableButton: UIButton = button == maleButton ? femaleButton : maleButton
        activeButton.backgroundColor = UIColor.white
        activeButton.setTitleColor(UIColor(red:228.0/255.0, green:54.0/255.0, blue:79.0/255.0, alpha:1.0), for: UIControlState.normal)
        disableButton.backgroundColor = UIColor(red:255.0/255.0, green:255.0/255.0, blue:255.0/255.0, alpha:0.5)
        disableButton.setTitleColor(UIColor(red:255.0/255.0, green:255.0/255.0, blue:255.0/255.0, alpha:1.0), for: UIControlState.normal)
    }
    
    @IBAction func onMaleButtonTap(_ sender: Any) {
        activateButton(button: maleButton)
    }
    
    @IBAction func onFemaleButtonTap(_ sender: Any) {
        activateButton(button: femaleButton)
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

