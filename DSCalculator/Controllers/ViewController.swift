//
//  ViewController.swift
//  DSCalculator
//
//  Created by Mac on 26.07.17.
//  Copyright © 2017 Dmitry. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var displayLable: UILabel!
    @IBOutlet weak var acButton: DSButtons!
    @IBOutlet var specialButtons: [DSButtons]!
    @IBOutlet var digitalButtons: [DSButtons]!
    @IBOutlet var mathOperationButtons: [DSButtons]!
    
    let calculator = DSCalculator()
    var mathOperationType: Int?
    var operandInString: String = ""
    var secondDigit: Double = 0
    var isSecondDigitEditing: Bool = false
    var isComma: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        }

    func resetBorderButtons(buttons1: Array<DSButtons>, buttons2: Array<DSButtons>) {
        let sharedArray: [DSButtons] = buttons1 + buttons2
        for button: DSButtons in sharedArray {
            button.layer.borderColor = UIColor.lightGray.cgColor
        }
    }
    
    func resetBaseParameters() {
        isSecondDigitEditing = false
        isComma = false
    }

    func handlerToCalculator () {
        guard let mathOperationSign = mathOperationType else { return }
        let result: Double = calculator.resultCalculation(operand: secondDigit, mathSign: mathOperationSign)
        displayLable.text = "\(result)"
    }
    
    //MARK: - ActionMethods
    
    @IBAction func inputNumberrButtonPressed(_ sender: DSButtons) {
        
        if isComma && sender.tag == 10 { return }
        var signFromTag: String = ""
        
        if sender.tag == 10 {
            signFromTag = "."
            isComma = true
        } else {
            signFromTag = "\(sender.tag)"
        }
        operandInString .append(signFromTag)
        
        if acButton.titleLabel?.text == "AC" {
            acButton .setTitle("C", for: UIControlState.normal)
        }
        resetBorderButtons(buttons1: mathOperationButtons, buttons2: digitalButtons)
        sender.layer.borderColor = UIColor.gray.cgColor

        guard let operandInDigit: Double = Double(operandInString) else { return }

        if !isSecondDigitEditing {
            calculator.accumulator = operandInDigit
        } else {
            secondDigit = operandInDigit
        }
        displayLable.text = "\(operandInDigit)"
    }

    @IBAction func inputMathSignButtonPressed(_ sender: DSButtons) {
        resetBorderButtons(buttons1: mathOperationButtons, buttons2: digitalButtons)
        isComma = false
        operandInString = ""
        mathOperationType = sender.tag
        isSecondDigitEditing = true
        sender.layer.borderColor = UIColor.gray.cgColor
    }
    
    @IBAction func resultButtonPressed(_ sender: DSButtons) {
        handlerToCalculator()
        resetBorderButtons(buttons1: mathOperationButtons, buttons2: digitalButtons)
        operandInString = displayLable.text!
        resetBaseParameters()
    }
    
    
    @IBAction func clearResultButtonPressed(_ sender: DSButtons) {
        resetBorderButtons(buttons1: mathOperationButtons, buttons2: digitalButtons)
        acButton .setTitle("AC", for: UIControlState.normal)
        displayLable.text = "0"
        operandInString = ""
        calculator.clear()
        resetBaseParameters()
    }
    
    @IBAction func changeSignButtonPressed(_ sender: DSButtons) {
        mathOperationType = sender.tag
        handlerToCalculator()
    }
    
    @IBAction func percentsButtonPressed(_ sender: DSButtons) {
        
        guard let mathOperationSign = mathOperationType else { return }
        let result: Double = calculator.calculationPercent(operand: secondDigit, mathSign: mathOperationSign)
        displayLable.text = "\(result)"
        resetBorderButtons(buttons1: mathOperationButtons, buttons2: digitalButtons)
        operandInString = displayLable.text!
        resetBaseParameters()
    }
}



