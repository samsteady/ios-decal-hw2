//
//  ViewController.swift
//  SwiftCalc
//
//  Created by Zach Zeleznick on 9/20/16.
//  Copyright © 2016 zzeleznick. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // MARK: Width and Height of Screen for Layout
    var w: CGFloat!
    var h: CGFloat!
    

    // IMPORTANT: Do NOT modify the name or class of resultLabel.
    //            We will be using the result label to run autograded tests.
    // MARK: The label to display our calculations
    var resultLabel = UILabel()
    
    // TODO: This looks like a good place to add some data structures.
    //       One data structure is initialized below for reference.
    var toEval = ""
    var evalOp = ""
    var resultValue = "0"
    var wasOp = false

    override func viewDidLoad() {
        super.viewDidLoad()
        view = UIView(frame: UIScreen.main.bounds)
        view.backgroundColor = UIColor(white: 1.0, alpha: 1.0)
        w = view.bounds.size.width
        h = view.bounds.size.height
        navigationItem.title = "Calculator"
        // IMPORTANT: Do NOT modify the accessibilityValue of resultLabel.
        //            We will be using the result label to run autograded tests.
        resultLabel.accessibilityValue = "resultLabel"
        makeButtons()
        // Do any additional setup here.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // TODO: A method to update your data structure(s) would be nice.
    //       Modify this one or create your own.
    func updateToEvalString(_ content: String) {
      toEval = content
    }
    
    // TODO: Ensure that resultLabel gets updated.
    //       Modify this one or create your own.
    func updateResultLabel(_ content: String) {
        if ([Character](content.characters).count <= 7) {
            resultValue = content
            resultLabel.text! = content
            
        } else {
            let first = content.substring(to: content.index(content.startIndex, offsetBy: 7))
            resultValue = first
            resultLabel.text! = first
        }
    }
    
    
    // TODO: A calculate method with no parameters, scary!
    //       Modify this one or create your own.
    func calculate() -> String {
        return "0"
    }
    
    // TODO: A simple calculate method for integers.
    //       Modify this one or create your own.
    func intCalculate(a: Int, b:Int, operation: String) -> Int {
        print("Calculation requested for \(a) \(operation) \(b)")
        return 0
    }
    
    // TODO: A general calculate method for doubles
    //       Modify this one or create your own.
    func calculate(a: String, b:String, operation: String) -> Double {
        print("Calculation requested for \(a) \(operation) \(b)")
        return 0.0
    }
    
    // REQUIRED: The responder to a number button being pressed.
    func numberPressed(_ sender: CustomButton) {
        guard Int(sender.content) != nil else { return }
        print("The number \(sender.content) was pressed")
        wasOp = false
        if(resultValue == "0") {
            updateResultLabel(sender.content)
        } else if (resultValue == "-0") {
            updateResultLabel("-" + sender.content)
        } else {
            updateResultLabel(resultValue + sender.content)
        }
    }
    
    // REQUIRED: The responder to an operator button being pressed.
    func operatorPressed(_ sender: CustomButton) {
        // Fill me in!
        switch sender.content {
        case "C":
            updateResultLabel("0")
            toEval = ""
            evalOp = ""
            break
        case "+/-":
            if(resultValue[resultValue.startIndex] == "-") {
                resultValue.remove(at: resultValue.startIndex);
            } else {
                updateResultLabel("-" + resultValue)
            }
            break
        case "%":
            var chars = [Character](resultValue.characters)
            if let indexOfDot = chars.index(of: ".") {
                chars.remove(at: indexOfDot)
                var allZero = true
                for c in chars {
                    if (c != "0") {
                        allZero = false
                    }
                }
                if (allZero) {
                    updateResultLabel("0")
                    break
                } else if (indexOfDot >= 2) {
                    chars.insert(".", at: indexOfDot-2)
                } else if (indexOfDot == 1) {
                    chars.insert("0", at: 0)
                    chars.insert(".", at: 0)
                } else if (indexOfDot == 0) {
                    chars.insert("0", at: 0)
                    chars.insert("0", at: 0)
                    chars.insert(".", at: 0)
                }

            } else {
                var allZero = true
                for c in chars {
                    if (c != "0") {
                        allZero = false
                    }
                }
                if (allZero) {
                    updateResultLabel("0")
                    break
                } else if (chars.count >= 2) {
                    chars.insert(".", at: chars.count-2)
                } else if (chars.count == 1) {
                    chars.insert("0", at: 0)
                    chars.insert(".", at: 0)
                }
            }
            updateResultLabel(String(chars))
            break
            case "/":
                if (wasOp) {
                    evalOp = "/"
                } else {
                    wasOp = true
                    print(evalOp)
                    print(toEval)
                    if (evalOp != "" && toEval != "") {
                        evaluate(resultValue, evalOp, toEval)
                    }
                    evalOp = "/"
                    toEval = resultValue
                    resultValue = "0"
                }
                break
            case "*":
                if (wasOp) {
                    evalOp = "*"
                } else {
                    wasOp = true
                    if (evalOp != "" && toEval != "") {
                        evaluate(resultValue, evalOp, toEval)
                    }
                    evalOp = "*"
                    toEval = resultValue
                    resultValue = "0"
                }
                break
            case "-":
                if (wasOp) {
                    evalOp = "-"
                } else {
                    wasOp = true
                    if (evalOp != "" && toEval != "") {
                        evaluate(resultValue, evalOp, toEval)
                    }
                    evalOp = "-"
                    toEval = resultValue
                    resultValue = "0"
                }
                break
            case "+":
                if (wasOp) {
                    evalOp = "+"
                } else {
                    wasOp = true
                    if (evalOp != "" && toEval != "") {
                        evaluate(resultValue, evalOp, toEval)
                    }
                    evalOp = "+"
                    toEval = resultValue
                    resultValue = "0"
                }
                break
            case "=":
                if (wasOp) {
                    break
                }
                if (evalOp != "" && toEval != "") {
                    evaluate(resultValue, evalOp, toEval)
                    toEval = resultValue
                    evalOp = ""
                }
                break
        default:
            print("ERROR")
        }
    }
    
    func evaluate(_ s2: String, _ op: String, _ s1: String) {
        var s2Num = Double(s2)!
        var s1Num = Double(s1)!
        switch op {
        case "/":
            if (s2Num == 0) {
                print("ERROR - Cannot divide by 0")
            } else if (s1Num < s2Num) {
                var chars1 = [Character](s1.characters)
                var chars2 = [Character](s2.characters)
                if !chars1.contains(".") {
                    chars1.insert(".", at: chars1.count)
                    chars1.insert("0", at: chars1.count)
                }
                if !chars2.contains(".") {
                    chars2.insert(".", at: chars2.count)
                    chars2.insert("0", at: chars2.count)
                }
                let s1D = String(chars1)
                let s2D = String(chars2)
                print(s1D)
                print(s2D)
                s2Num = Double(s2D)!
                s1Num = Double(s1D)!
                let val = s1Num / s2Num
                print(val)
                let strVal = String(val)
                updateResultLabel(strVal)
            } else if (s1Num.truncatingRemainder(dividingBy: s2Num) == 0) {
                let val = s1Num / s2Num
                var strVal = String(val)
                var chars = [Character](strVal.characters)
                chars.remove(at: chars.count-1)
                chars.remove(at: chars.count-1)
                strVal = String(chars)
                updateResultLabel(strVal)
            } else {
                let val = s1Num / s2Num
                let strVal = String(val)
                updateResultLabel(strVal)
            }
            break
        case "*":
            let product = s1Num*s2Num
            if (product.truncatingRemainder(dividingBy: 1) == 0) {
                var strVal = String(product)
                var chars = [Character](strVal.characters)
                chars.remove(at: chars.count-1)
                chars.remove(at: chars.count-1)
                strVal = String(chars)
                updateResultLabel(strVal)

            } else {
                updateResultLabel(String(product))
            }
            break
        case "-":
            let sub = s1Num-s2Num
            if (sub.truncatingRemainder(dividingBy: 1) == 0) {
                var strVal = String(sub)
                var chars = [Character](strVal.characters)
                chars.remove(at: chars.count-1)
                chars.remove(at: chars.count-1)
                strVal = String(chars)
                updateResultLabel(strVal)
                
            } else {
                updateResultLabel(String(sub))
            }
        case "+":
            let sum = s1Num+s2Num
            if (sum.truncatingRemainder(dividingBy: 1) == 0) {
                var strVal = String(sum)
                var chars = [Character](strVal.characters)
                chars.remove(at: chars.count-1)
                chars.remove(at: chars.count-1)
                strVal = String(chars)
                updateResultLabel(strVal)
                
            } else {
                updateResultLabel(String(sum))
            }
        default:
            print("ERROR")
        }
    }
    
    // REQUIRED: The responder to a number or operator button being pressed.
    func buttonPressed(_ sender: CustomButton) {
        wasOp = false
        switch sender.content {
        case "0":
            if(resultValue == "0") {
                updateResultLabel(sender.content)
            } else {
                updateResultLabel(resultValue + "0")
            }
            break
        case ".":
            let chars = [Character](resultValue.characters)
            if (chars.index(of: ".") == nil) {
                updateResultLabel(resultValue+".")
            }
            break
        default:
            print("ERROR")
        }
    }
    
    // IMPORTANT: Do NOT change any of the code below.
    //            We will be using these buttons to run autograded tests.
    
    func makeButtons() {
        // MARK: Adds buttons
        let digits = (1..<10).map({
            return String($0)
        })
        let operators = ["/", "*", "-", "+", "="]
        let others = ["C", "+/-", "%"]
        let special = ["0", "."]
        
        let displayContainer = UIView()
        view.addUIElement(displayContainer, frame: CGRect(x: 0, y: 0, width: w, height: 160)) { element in
            guard let container = element as? UIView else { return }
            container.backgroundColor = UIColor.black
        }
        displayContainer.addUIElement(resultLabel, text: "0", frame: CGRect(x: 70, y: 70, width: w-70, height: 90)) {
            element in
            guard let label = element as? UILabel else { return }
            label.textColor = UIColor.white
            label.font = UIFont(name: label.font.fontName, size: 60)
            label.textAlignment = NSTextAlignment.right
        }
        
        let calcContainer = UIView()
        view.addUIElement(calcContainer, frame: CGRect(x: 0, y: 160, width: w, height: h-160)) { element in
            guard let container = element as? UIView else { return }
            container.backgroundColor = UIColor.black
        }

        let margin: CGFloat = 1.0
        let buttonWidth: CGFloat = w / 4.0
        let buttonHeight: CGFloat = 100.0
        
        // MARK: Top Row
        for (i, el) in others.enumerated() {
            let x = (CGFloat(i%3) + 1.0) * margin + (CGFloat(i%3) * buttonWidth)
            let y = (CGFloat(i/3) + 1.0) * margin + (CGFloat(i/3) * buttonHeight)
            calcContainer.addUIElement(CustomButton(content: el), text: el,
            frame: CGRect(x: x, y: y, width: buttonWidth, height: buttonHeight)) { element in
                guard let button = element as? UIButton else { return }
                button.addTarget(self, action: #selector(operatorPressed), for: .touchUpInside)
            }
        }
        // MARK: Second Row 3x3
        for (i, digit) in digits.enumerated() {
            let x = (CGFloat(i%3) + 1.0) * margin + (CGFloat(i%3) * buttonWidth)
            let y = (CGFloat(i/3) + 1.0) * margin + (CGFloat(i/3) * buttonHeight)
            calcContainer.addUIElement(CustomButton(content: digit), text: digit,
            frame: CGRect(x: x, y: y+101.0, width: buttonWidth, height: buttonHeight)) { element in
                guard let button = element as? UIButton else { return }
                button.addTarget(self, action: #selector(numberPressed), for: .touchUpInside)
            }
        }
        // MARK: Vertical Column of Operators
        for (i, el) in operators.enumerated() {
            let x = (CGFloat(3) + 1.0) * margin + (CGFloat(3) * buttonWidth)
            let y = (CGFloat(i) + 1.0) * margin + (CGFloat(i) * buttonHeight)
            calcContainer.addUIElement(CustomButton(content: el), text: el,
            frame: CGRect(x: x, y: y, width: buttonWidth, height: buttonHeight)) { element in
                guard let button = element as? UIButton else { return }
                button.backgroundColor = UIColor.orange
                button.setTitleColor(UIColor.white, for: .normal)
                button.addTarget(self, action: #selector(operatorPressed), for: .touchUpInside)
            }
        }
        // MARK: Last Row for big 0 and .
        for (i, el) in special.enumerated() {
            let myWidth = buttonWidth * (CGFloat((i+1)%2) + 1.0) + margin * (CGFloat((i+1)%2))
            let x = (CGFloat(2*i) + 1.0) * margin + buttonWidth * (CGFloat(i*2))
            calcContainer.addUIElement(CustomButton(content: el), text: el,
            frame: CGRect(x: x, y: 405, width: myWidth, height: buttonHeight)) { element in
                guard let button = element as? UIButton else { return }
                button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
            }
        }
    }

}

