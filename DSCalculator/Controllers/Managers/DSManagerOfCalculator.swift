//
//  DSManagerOfCalculator.swift
//  DSCalculator
//
//  Created by Mac on 04.08.17.
//  Copyright © 2017 Dmitry. All rights reserved.
//

import UIKit

class DSManagerOfCalculator {

    let calculator = DSCalculator()
    var mathOperationType: Int?
    var operandInString = ""
    var secondDigit: Double?
    var isSecondDigitEditing = false
    var isComma = false
    
    
    func resetBaseParameters() {
        isSecondDigitEditing = false
        isComma = false
    }
    
    func handlerToCalculator () -> String? {
        guard let mathOperationSign = mathOperationType, let secondDigit = secondDigit else { return nil }
        let result: Double = calculator.resultCalculation(operand: secondDigit, mathSign: mathOperationSign)
        return "\(result)"
    }

    func inputNumber(_ senderTag: Int) {
        
        if (isComma && senderTag == 10) || (mathOperationType == nil && isSecondDigitEditing) { return }
        var signFromTag: String = ""
        if senderTag == 10 {
            signFromTag = "."
            isComma = true
        } else {
            signFromTag = "\(senderTag)"
        }
        operandInString .append(signFromTag)
        guard let operandInDigit = Double(operandInString) else { return }
        if !isSecondDigitEditing {
            calculator.accumulator = operandInDigit
        } else {
            secondDigit = operandInDigit
        }
    }
    
    func inputMathSign(_ senderTag: Int, text displayText: String!) -> String? {
        isComma = false
        operandInString = ""
        let textToDispley = mathSignPressed(text: displayText)
        mathOperationType = senderTag
        secondDigit = nil
        return textToDispley
    }
    
    func mathSignPressed(text displayText: String!) -> String? {
        var tempResult: String?
         if !isSecondDigitEditing {
            isSecondDigitEditing = true
        } else {
            tempResult = handlerToCalculator()
        }
        return tempResult
    }
    
    func resultPressed() {
        mathOperationType = nil
        isComma = false
    }
    
    func clearResultPressed() {
        operandInString = ""
        calculator.clear()
        resetBaseParameters()
        secondDigit = nil
    }
    
    func percentPressed(text displayText: String!) -> String? {
        guard let mathOperationSign = mathOperationType, let secondDigit = secondDigit else { return nil }
        let result: Double = calculator.calculationPercent(operand: secondDigit, mathSign: mathOperationSign)
        operandInString = displayText!
        resetBaseParameters()
        return "\(result)"
    }
    
}
