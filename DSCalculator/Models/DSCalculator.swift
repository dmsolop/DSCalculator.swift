//
//  DSCalculator.swift
//  DSCalculator
//
//  Created by Mac on 27.07.17.
//  Copyright © 2017 Dmitry. All rights reserved.
//

import UIKit

class DSCalculator {
    
    enum MathOperations: Int {
        case sum = 1, subtract, multiply, divide, changeSign
    }
    
    var mathOperation = MathOperations.sum
    var accumulator: Double = 0
    
    func clear() {
        accumulator = 0
    }
    
    private func sum(_ x: Double) -> Double {
         accumulator += x
         return accumulator
    }
    
    private func subtract(_ x: Double) -> Double {
        accumulator -= x
        return accumulator
    }
    
    private func multiply(_ x: Double) -> Double {
        accumulator *= x
        return accumulator
    }
    
    private func divide(_ x: Double) -> Double {
        if x != 0 {
            accumulator /= x
            return accumulator
        }else{
            accumulator = 0
            return accumulator
        }
    }
    
    private func changeSign() -> Double {
        accumulator = -accumulator
        return accumulator
    }
    
    func resultCalculation(operand secondValue: Double, mathSign sign: Int) -> Double {
        
        mathOperation = DSCalculator.MathOperations(rawValue: sign)!

            switch mathOperation {
            case .sum:
                return self.sum(secondValue)
            case .subtract:
                return self.subtract(secondValue)
            case .multiply:
                return self.multiply(secondValue)
            case .divide:
                return self.divide(secondValue)
            case .changeSign:
                return self.changeSign()
            }
    }
    
    func calculationPercent(operand secondValue: Double, mathSign sign: Int) -> Double {
        let result: Double = accumulator / 100 * secondValue
        return resultCalculation(operand: result, mathSign: sign)
    }

}
