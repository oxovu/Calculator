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
    var dot = false
    var operation = 0
    var previousOperation = false
    
    @IBOutlet var back: UIView!
    @IBOutlet weak var result: UILabel!
    
    @IBAction func point(_ sender: Any) {
        if !dot {
            if math {
                result.text = "0"
                math = false
            }
            result.text = result.text! + "."
            dot = true
        }
    }

    @IBAction func clear(_ sender: UIButton) {
        result.text = "0"
        previousNumber = 0
        numberOnScreen = 0
        operation = 0
        dot = false
    }
    
    @IBAction func numbers(_ sender: UIButton) {
        if result.text!.count < 9 {
        if result.text == "0" {
            result.text = ""
        }
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
        if result.text?.count == 9 && math {
            result.text = String(sender.tag - 1)
            numberOnScreen = Double(result.text!)!
            math = false
        }
    }
    
    @IBAction func percent(_ sender: UIButton) {
        if previousNumber == 0 {
            numberOnScreen = numberOnScreen / 100
        } else {
        numberOnScreen = previousNumber * numberOnScreen / 100
        }
        if (numberOnScreen.truncatingRemainder(dividingBy: 1)) == 0{
            intNumberOnScreen = Int(numberOnScreen)
            result.text = String(intNumberOnScreen)
        } else{
            result.text = String(numberOnScreen)
        }
    }
    
    @IBAction func plusMinus(_ sender: UIButton) {
        if (numberOnScreen.truncatingRemainder(dividingBy: 1)) == 0{
            intNumberOnScreen = Int(numberOnScreen)
            result.text = String(-intNumberOnScreen)
        } else{
            result.text = String(-numberOnScreen)
        }
        numberOnScreen = -numberOnScreen
    
    }
    
    @IBAction func operations(_ sender: UIButton) { // сделать, чтобы при нескольких нажатиях на операторы, выводился промежуточный результат
        var powOnScreen:Int = 0
        var charsAfterPoint:Int = 1
        dot = false
        if result.text != "" && sender.tag != 11 && sender.tag != 18 && sender.tag != 12 && sender.tag != 13 {
            operation = sender.tag
            previousNumber = Double(result.text!)!
            math = true
            previousOperation = true
        } else if sender.tag == 18 || !previousOperation {  // разобраться с previousOperation, чтобы был промежуточный результат
            if operation == 14 { //divide
                if numberOnScreen == 0 {
                    result.text = "error"
                } else {
                if previousNumber == 0 {
                    numberOnScreen = 0
                } else {
                numberOnScreen = previousNumber / numberOnScreen
                numberOnScreen = round(numberOnScreen * pow(10, 11)) / pow(10, 11)
                }
                } }
            if operation == 15 { //multiply
                numberOnScreen = previousNumber * numberOnScreen
            }
            if operation == 16 { //minus
                numberOnScreen = previousNumber - numberOnScreen
            }
            if operation == 17 { //plus
                numberOnScreen = previousNumber + numberOnScreen
            }
            if numberOnScreen > pow(10, 9) {
                charsAfterPoint = 0
                while numberOnScreen >= 10 {
                    powOnScreen += 1
                    if (numberOnScreen.truncatingRemainder(dividingBy: 10)) != 0 {
                        charsAfterPoint += 1
                    }
                    numberOnScreen = numberOnScreen / 10
                }
            }
            if numberOnScreen != 0 && abs(numberOnScreen) < pow(10, -5) {
                charsAfterPoint = 5
                while numberOnScreen < 1 {
                    powOnScreen -= 1
                    numberOnScreen = numberOnScreen * 10
                }
            }
            previousNumber = numberOnScreen
            if (numberOnScreen.truncatingRemainder(dividingBy: 1)) == 0 {
                intNumberOnScreen = Int(numberOnScreen)
                if result.text != "error" {
                   result.text = String(intNumberOnScreen)
                }
                if powOnScreen != 0 {
                    result.text = result.text! + "e" + String(powOnScreen)
                }
            } else {
                 charsAfterPoint = String(numberOnScreen.truncatingRemainder(dividingBy: 1)).count - 2
                if charsAfterPoint > 5 {
                    charsAfterPoint = 5
                }
                let stringFormat = "%.0" + String(describing: charsAfterPoint) + "f"  //странно выводится если все 9 умножить на что-то близкое ко всем 9
                result.text = String(format: stringFormat, numberOnScreen) //это изза округления
                if powOnScreen != 0 {
                    result.text = result.text! + "e" + String(powOnScreen) 
                }
            }
            previousOperation = false
            math = true
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

