//
//  CalculatorBrainModel.swift
//  CountOnMe
//
//  Created by Mathieu Janneau on 31/12/2017.
//  Copyright © 2017 Ambroise Collon. All rights reserved.
//

import Foundation
/**
 Handles all the logic for calculations
 */
struct CalculatorBrainModel {
  // MARK: - Properties
  var stringNumbers: [String] = [String()]
  var operators: [String] = ["+"]
  var index = 0

  /**
   Computed property that check if there is one nummber in number stack.
   if yes then you can add an operand
   */
  var canAddOperator: Bool {
    if let stringNumber = stringNumbers.last {
      if stringNumber.isEmpty {
        return false
      }
    }
    return true
  }

  /**
   When press operand this methods store operands and first number
   */
  mutating func sendOperandsToBrain(operand: String, number: String) {
    operators.append(operand)
    stringNumbers.append(number)
  }

  /**
   Add new number in the stack and memorize the former last one
   allows us to calculate numbers with more than one number long
 */
  mutating func addNewNumber(_ newNumber: Int) {
    if let stringNumber = stringNumbers.last {
      var stringNumberMutable = stringNumber
      //Convert Int to String and append it to the former number
      stringNumberMutable += "\(newNumber)"
      // Replace formernumber with apended number
      stringNumbers[stringNumbers.count-1] = stringNumberMutable
      
    }
  }
  /**
   Computed property that check if there is empty or have
   only one member in number stack. Then you cannot perform operation
   */
  var isExpressionCorrect: Bool {
    if let stringNumber = stringNumbers.last {
      if stringNumber.isEmpty {
        if stringNumbers.count == 1 {
          return false
        }
      }
    }
    return true
  }

/**
   Perform the operation between the 2 numbers in the stack.
   the operation can be + or - for the moment
   - todo: add operations
 */
  mutating func calculateTotal() -> Int {
    var total = 0
    // slices the memorized number
    for (i, stringNumber) in stringNumbers.enumerated() {
      //Convert string into Int to calculate
      if let number = Int(stringNumber) {
        // refactor in switch when adding new operations
        if operators[i] == "+" {
          total += number
        } else if operators[i] == "-" {
          total -= number
        }
      }
    }
    clear()
    return total
  }

  /**
   Clear the model's data
 */
  mutating func clear() {
    stringNumbers = [String()]
    operators = ["+"]
    index = 0
  }
}
