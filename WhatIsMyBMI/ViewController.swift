//
//  ViewController.swift
//  WhatIsMyBMI
//
//  Created by Henrik Raitasola on 08/01/17.
//  Copyright © 2017 Henrik Raitasola. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var heightSlider: UISlider!
    @IBOutlet weak var heightValue: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onHeightChange(_ sender: Any) {
        heightValue.text = "\(String(Int(heightSlider.value))) cm"
    }

}

