//
//  ViewController.swift
//  CountOnMe
//
//  Created by Ambroise COLLON on 30/08/2016.
//  Copyright © 2016 Ambroise Collon. All rights reserved.
//

import UIKit

/// This class handles the communication between
/// Main view and Calculator Model. it send all information from user input
/// to calculator Brain and send back processed calculation results to the view
class CalculatorViewController: UIViewController {
  
  // /////////////////// //
  // MARK: - PROPERTIES  //
  // /////////////////// //
  
  /// Instantiate model
  var brain = CalculatorBrainModel()
  
  // //////////////// //
  // MARK: - OUTLETS //
  // //////////////// //
  
  /// Connect the textView to the controller
  @IBOutlet weak var textView: UITextView!
  /// Connect the decimal point button view to the controller
  @IBOutlet weak var point: UIButton!
  /// Gather all the number buttons and connect it to the controller
  @IBOutlet var numberButtons: [UIButton]!
  /// Gather all the operators buttons and connect it to the controller
  @IBOutlet var operators: [UIButton]!
  
  // ///////////////////////// //
  // MARK: - LIFECYCLE METHODS //
  // ///////////////////////// //
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  // //////////////// //
  // MARK: - ACTIONS //
  // //////////////// //
  
  /// Method that sends the number keystroke input in
  /// model property stringNumbers and accordingly update display
  /// *** this action applies to all the member of numberButtons outlet Collection.
  /// - Parameter sender: UIButton pressed
  @IBAction func tappedNumberButton(_ sender: UIButton) {
    for (i, numberButton) in numberButtons.enumerated() where sender == numberButton {
      brain.addNewNumber(i)
      updateDisplay()
    }
  }
  /// Method that sends the operator keystroke input in
  /// model property operators and accordingly update display
  /// *** this action applies to all the member of operators outlet Collection. ***
  /// - Parameter sender: UIButton pressed
  @IBAction func operandButtonTapped(_ sender: UIButton) {
    performOperation(operand: (sender.titleLabel?.text!)!)
  }
  
  /// Method that insert a decimal point in stringNumbers.
  /// ** there can be only one decimal point in a number **
  /// - Parameter sender: <#sender description#>
  @IBAction func tappedPointButton(_ sender: Any) {
    if brain.canAddDecimal {
      brain.addDecimal()
      updateDisplay()
    } else {
      showAlert(message: "il ne peut y avoir qu'un point")
    }
  }
  
  /// Process the calculation. It calls the calculateTotal() Method from brain.
  @IBAction func equal() {
    // check if this is a valid calculation
    if !brain.isExpressionCorrect {
      // display alert if incorrect
      showAlert(message: "opération invalide")
    } else {
      // process calcultation
      let total = brain.calculateTotal()
      // round if it s an integer
      if brain.roundEvaluation(total){
        textView.text! += "\n =\(Int(total))"
      } else {
        textView.text! += "\n =\(total)"
      }
    }
  }
  
  /// Resets the display and the calculator brain storage to empty
  ///
  /// - Parameter sender: UIButton
  @IBAction func allClear(_ sender: UIButton) {
    brain.allClear()
    textView.text = "0"
  }
  
  
  // //////////////// //
  // MARK: - METHODS //
  // //////////////// //
  
  /// Display an alert Controller to explain the user the rror
  ///
  /// - Parameter message: String the message you wan to display
  func showAlert(message: String) {
    // instantiate alertController
    let alertVC = UIAlertController(title: "Erreur!", message: message, preferredStyle: .alert)
    // add cancel button
    alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
    self.present(alertVC, animated: true, completion: nil)
  }
  
  
  /// Perform operation and update display
  ///
  /// - Parameter operand: String representing the mathematical operand
  func performOperation(operand:String) {
    if brain.canAddOperator {
      // check if we use the former result
      let result = brain.formerResult
      if result != nil {
        // round result if needed
        brain.roundResult(result)
        // display the operand on textView and send the operand in stack
        updateDisplayForResultReuse(operand: operand)
      } else {
        // send the operand in stack
        brain.sendOperandsToBrain(operand: operand, number: "")
        // display the operand on textView
        updateDisplay()}
    } else {
      showAlert(message: "Expression incorrecte !")
    }
  }
  
  /// Interactively update TextView to display keystrokes and results
  func updateDisplay() {
    var text = ""
    // call the existing display string
    let stack = brain.stringNumbers.enumerated()
    for (i, stringNumber) in stack {
      // Add operator
      if i > 0 {
        text += brain.operators[i]
      }
      // Add number
      text += stringNumber
    }
    // update display from stack infromations
    textView.text = text
  }
  
  /// Reload former result when the user presses an operand
  /// after a calculation
  /// - Parameter operand: String the operand
  private func updateDisplayForResultReuse(operand: String) {
    // reset display to show the result
    updateDisplay()
    // Store a the operand in the operand stack
    brain.sendOperandsToBrain(operand: operand, number: "")
    //update display to show the operand
    updateDisplay()
  }
  
}

