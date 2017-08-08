//
//  SecondViewController.swift
//  DSCalculator
//
//  Created by Mac on 07.08.17.
//  Copyright © 2017 Dmitry. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var displayLable: UILabel!
    @IBOutlet weak var acButton: DSButtons!
    @IBOutlet var specialButtons: [DSButtons]!
    @IBOutlet var digitalButtons: [DSButtons]!
    @IBOutlet var mathOperationButtons: [DSButtons]!
    
    let managerCalculator = DSManagerOfCalculator()
    let firstController = ViewController()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        displayLable.text = "\(managerCalculator.calculator.accumulator)"
    }
    
    func resetBorderButtons(buttons1: Array<DSButtons>, buttons2: Array<DSButtons>) {
        let sharedArray: [DSButtons] = buttons1 + buttons2
        for button: DSButtons in sharedArray {
            button.layer.borderColor = UIColor.lightGray.cgColor
        }
    }
    
    //MARK: - ActionMethods
    
    @IBAction func inputNumberrButtonPressed(_ sender: DSButtons) {
        managerCalculator.inputNumber(sender.tag)
        displayLable.text = managerCalculator.operandInString
        
        if acButton.titleLabel?.text == "AC" {
            acButton .setTitle("C", for: UIControlState.normal)
        }
        resetBorderButtons(buttons1: mathOperationButtons, buttons2: digitalButtons)
        sender.layer.borderColor = UIColor.gray.cgColor
    }
    
    @IBAction func inputMathSignButtonPressed(_ sender: DSButtons) {
        if let displayText = managerCalculator.inputMathSign(sender.tag, text: displayLable.text) {
            displayLable.text = displayText
        }
        
        resetBorderButtons(buttons1: mathOperationButtons, buttons2: digitalButtons)
        sender.layer.borderColor = UIColor.gray.cgColor
    }
    
    @IBAction func resultButtonPressed(_ sender: DSButtons) {
        guard let displayText = managerCalculator.handlerToCalculator() else { return }
        displayLable.text = displayText
        managerCalculator.operandInString = displayLable.text!
        managerCalculator.resultPressed()
        
        resetBorderButtons(buttons1: mathOperationButtons, buttons2: digitalButtons)
    }
    
    
    @IBAction func clearResultButtonPressed(_ sender: DSButtons) {
        resetBorderButtons(buttons1: mathOperationButtons, buttons2: digitalButtons)
        acButton .setTitle("AC", for: UIControlState.normal)
        displayLable.text = "0"
        
        managerCalculator.clearResultPressed()
    }
    
    @IBAction func changeSignButtonPressed(_ sender: DSButtons) {
        managerCalculator.mathOperationType = sender.tag
        displayLable.text = managerCalculator.handlerToCalculator()
    }
    
    @IBAction func percentsButtonPressed(_ sender: DSButtons) {
        resetBorderButtons(buttons1: mathOperationButtons, buttons2: digitalButtons)
        
        displayLable.text = managerCalculator.percentPressed(text: displayLable.text)
    }

    //MARK: - NavigationMethods
    
    override func willRotate(to toInterfaceOrientation: UIInterfaceOrientation, duration: TimeInterval) {
        if toInterfaceOrientation.isPortrait {
            dismiss(animated: true, completion: {
                self.firstController.viewDidLoad()
            })
        }
    }

}
