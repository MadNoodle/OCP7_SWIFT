//
//  CalculatorBrainModel.swift
//  CountOnMe
//
//  Created by Mathieu Janneau on 31/12/2017.
//  Copyright © 2017 Ambroise Collon. All rights reserved.
//

import Foundation

struct CalculatorBrainModel {
  
   var stringNumbers: [String] = [String()]
    var operators: [String] = ["+"]
   var index = 0
  
  var isExpressionCorrect: Bool {
    if let stringNumber = stringNumbers.last {
      if stringNumber.isEmpty {
        if stringNumbers.count == 1 {
          return false
        }
        return false
      }
    }
    return true
  }
  
  var canAddOperator: Bool {
    if let stringNumber = stringNumbers.last {
      if stringNumber.isEmpty {
        return false
      }
    }
    return true
  }

  mutating func performOperation(operand: String, number: String){
    operators.append(operand)
    stringNumbers.append(number)
  }
  
  mutating func addNewNumber(_ newNumber: Int) {
    if let stringNumber = stringNumbers.last {
      var stringNumberMutable = stringNumber
      stringNumberMutable += "\(newNumber)"
      stringNumbers[stringNumbers.count-1] = stringNumberMutable
    }
    
  }
  
  mutating func calculateTotal() -> Int {
    var total = 0
    for (i, stringNumber) in stringNumbers.enumerated() {
      if let number = Int(stringNumber) {
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
  
  mutating func clear() {
    stringNumbers = [String()]
    operators = ["+"]
    index = 0
  }
}
