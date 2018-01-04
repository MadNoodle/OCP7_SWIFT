//
//  ViewController.swift
//  CountOnMe
//
//  Created by Ambroise COLLON on 30/08/2016.
//  Copyright © 2016 Ambroise Collon. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {
  // MARK: - MODEL
  var brain = CalculatorBrainModel()
  // MARK: - Outlets
  @IBOutlet weak var textView: UITextView!
  @IBOutlet var numberButtons: [UIButton]!
  @IBOutlet weak var point: UIButton!
  
  // MARK: - LifeCycle MMethods
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  // MARK: - Action
  @IBAction func tappedNumberButton(_ sender: UIButton) {
    for (i, numberButton) in numberButtons.enumerated() where sender == numberButton {
      brain.addNewNumber(i)
      updateDisplay()
    }
  }
  
  @IBAction func tappedPointButton(_ sender: Any) {
    if brain.canAddDecimal {
      brain.addDecimal()
      updateDisplay()
    } else {
      showAlert()
    }
  }
  
  @IBAction func plus() {
    if brain.canAddOperator {
      let result = brain.formerResult
      if result != nil {
        if brain.roundEvaluation(result!){
          let rounded = Int(result!)
          brain.stringNumbers = ["\(rounded)"]
          brain.formerResult = nil
        }
        updateDisplayForResultReuse(operand: "+")
      } else {
        brain.sendOperandsToBrain(operand: "+", number: "")
        updateDisplay()}
    } else {
      showAlert()
    }
  }
  
  @IBAction func minus() {
    if brain.canAddOperator {
      let result = brain.formerResult
      if result != nil {
        if brain.roundEvaluation(result!){
          let rounded = Int(result!)
          brain.stringNumbers = ["\(rounded)"]
          brain.formerResult = nil
        }
        updateDisplayForResultReuse(operand: "-")
      } else {
        brain.sendOperandsToBrain(operand: "-", number: "")
        updateDisplay()}
    } else {
      showAlert()
    }
  }
  
  @IBAction func multiply(_ sender: Any) {
    if brain.canAddOperator {
      let result = brain.formerResult
      if result != nil {
        if brain.roundEvaluation(result!){
          let rounded = Int(result!)
          brain.stringNumbers = ["\(rounded)"]
          brain.formerResult = nil
        }
        updateDisplayForResultReuse(operand: "x")
      } else {
        brain.sendOperandsToBrain(operand: "x", number: "")
        updateDisplay()}
    } else {
      showAlert()
    }
  }
  

  
  @IBAction func divide(_ sender: Any) {
    if brain.canAddOperator {
      let result = brain.formerResult
      if result != nil {
        if brain.roundEvaluation(result!){
          let rounded = Int(result!)
          brain.stringNumbers = ["\(rounded)"]
          brain.formerResult = nil
        }
        updateDisplayForResultReuse(operand: "/")
      } else {
        brain.sendOperandsToBrain(operand: "/", number: "")
        updateDisplay()}
    } else {
      showAlert()
    }
  }
  
  @IBAction func equal() {
    if !brain.isExpressionCorrect {
      showAlert()
    } else {
      let total = brain.calculateTotal()
      if brain.roundEvaluation(total){
        textView.text! += "\n =\(Int(total))"
      } else {
        textView.text! += "\n =\(total)"
      }
    }
  }
  
  @IBAction func allClear(_ sender: UIButton) {
    brain.allClear()
    textView.text = "0"
  }
  
  // MARK: - Methods
  func showAlert() {
    let alertVC = UIAlertController(title: "Zéro!", message: "Expression incorrecte !", preferredStyle: .alert)
    alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
    self.present(alertVC, animated: true, completion: nil)
  }
  
  func updateDisplay() {
    var text = ""
    let stack = brain.stringNumbers.enumerated()
    for (i, stringNumber) in stack {
      // Add operator
      if i > 0 {
        text += brain.operators[i]
      }
      // Add number
      text += stringNumber
    }
    textView.text = text
  }
  private func updateDisplayForResultReuse(operand: String) {
    updateDisplay()
    brain.sendOperandsToBrain(operand: operand, number: "")
    updateDisplay()
  }
  
}

