//
//  ViewController.swift
//  Calculator
//
//  Created by Slava Vasileva on 29.06.2018.
//  Copyright © 2018 Slava Vasileva. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var numberOnScreen:Double = 0
    var intNumberOnScreen:Int = 0
    var previousNumber:Double = 0
    var math = false
    var operation = 0
    
    @IBOutlet var back: UIView!
    @IBOutlet weak var result: UILabel!
    
    @IBAction func point(_ sender: Any) {
        result.text = result.text! + "."
    }

    @IBAction func numbers(_ sender: UIButton) {
        if math {
            result.text = String(sender.tag - 1)
            numberOnScreen = Double(result.text!)!
            math = false
        } else {
            result.text = result.text! + String(sender.tag - 1)
            numberOnScreen = Double(result.text!)!
        }
        if numberOnScreen == 666{
            back.backgroundColor = UIColor(red: 0.9, green: 0.2, blue: 0.2, alpha: 1.0)
            result.textColor = UIColor.black
        } else {
            back.backgroundColor = UIColor(red: 0.26, green: 0.26, blue: 0.26, alpha: 1.0)
            result.textColor = UIColor.white
        }
    }
    
    @IBAction func percent(_ sender: UIButton) {
        if sender.tag == 13 { //%
            numberOnScreen = previousNumber * numberOnScreen / 100
        }
        if (numberOnScreen.truncatingRemainder(dividingBy: 1)) == 0{
            intNumberOnScreen = Int(numberOnScreen)
            result.text = String(intNumberOnScreen)
        } else{
            result.text = String(numberOnScreen)
        }
    }
    
    @IBAction func operations(_ sender: UIButton) {
        if result.text != "" && sender.tag != 11 && sender.tag != 18 {
            operation = sender.tag
            previousNumber = Double(result.text!)!
            math = true
            if operation == 12 { //±
                result.text = String(numberOnScreen * (-1))
            }
        } else if sender.tag == 18 {
            if operation == 14 { //divide
                numberOnScreen = previousNumber / numberOnScreen
            }
            if operation == 15 { //multiply
                numberOnScreen = previousNumber * numberOnScreen
            }
            if operation == 16 { //minus
                numberOnScreen = previousNumber - numberOnScreen
            }
            if operation == 17 { //plus
                numberOnScreen = previousNumber + numberOnScreen
            }
            if (numberOnScreen.truncatingRemainder(dividingBy: 1)) == 0{
                intNumberOnScreen = Int(numberOnScreen)
                result.text = String(intNumberOnScreen)
            } else{
                result.text = String(numberOnScreen)
            }
        } else if sender.tag == 11 {
            result.text = "0"
            previousNumber = 0
            numberOnScreen = 0
            operation = 0
        }
        if result.text == String(666){
            back.backgroundColor = UIColor(red: 0.9, green: 0.2, blue: 0.2, alpha: 1.0)
            result.textColor = UIColor.black
        } else {
            back.backgroundColor = UIColor(red: 0.26, green: 0.26, blue: 0.26, alpha: 1.0)
            result.textColor = UIColor.white
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

