//
//  Zozor_Tests.swift
//  CountOnMeTests
//
//  Created by Ambroise COLLON on 30/08/2016.
//  Copyright © 2016 Ambroise Collon. All rights reserved.
//

import XCTest
@testable import CountOnMe

class CountOnMeTests: XCTestCase {
  // MARK: properties
  var brain = CalculatorBrainModel()
  // MARK: setup
  override func setUp() {
    super.setUp()
    brain.clear()
  }
  
  // MARK: - Testing CalculatorBrain canAddNumber Computed Var
  func testGivenStringNumbersIsEmpty_whenAddNumberTriggered_thenSendsFalse(){
    //Set stringNumbers to Empty
    brain.stringNumbers = [String()]
    XCTAssertFalse(brain.canAddOperator)
  }
  
  func testGivenStringNumbersCountHasEmptyString_whenAddNumberIsTriggered_thenSendsFalse(){
    brain.stringNumbers = [""]
    XCTAssertFalse(brain.canAddOperator)
  }
  
  func testGivenStringNumbersContainsOneChar_whenAddNumberIsTriggered_thenSendsTrue(){
    brain.stringNumbers = ["1"]
    XCTAssert(brain.canAddOperator)
  }
  
  // MARK: Testing add Decimal
  func testGivenNumberInStack_whenDecimalPointIsTapped_thenDecimalNumberIsreturned(){
    brain.stringNumbers = ["0"]
    brain.addDecimal()
    XCTAssertEqual(brain.stringNumbers, ["0."])
  }
  
  func testGivenNumberInStackIsDecimal_whenDecimalIsTapped_thenPointCannotBeAdded(){
      brain.stringNumbers = ["0.0"]
      XCTAssertFalse(brain.canAddDecimal)
  }
  func testGivenNumberInStackIsNotDecimal_whenDecimalIsTapped_thenPointCannotBeAdded(){
    brain.stringNumbers = ["0"]
    XCTAssert(brain.canAddDecimal)
  }
  
  func testGivenNumberStackIsEmpty_whenDecimalIsTapped_thenPointCannotBeAdded(){
      brain.stringNumbers = [String()]
      XCTAssertFalse(brain.canAddDecimal)
  }
  
  
  // MARK: - Testing CalculatorBrain number storing
  func testGivenStackIsEmpty_WhenPressNumber_thenStackIsPopulated() {
    brain.addNewNumber(1)
    XCTAssert(brain.stringNumbers == ["1"])
  }
  
  func testGivenStackIsPopulated_WhenPressNumber_thenStackNumberAppendNewNumber() {
    brain.stringNumbers = ["10"]
    brain.addNewNumber(1)
    XCTAssert(brain.stringNumbers == ["101"])
  }
  
  // MARK: - Testing CalculatorBrain operand storing
  func testGivenOperatorStackIsInitial_whenOperatorButtonIsPressed_ThenOperatorStackAppendOperator() {
    brain.sendOperandsToBrain(operand: "+", number: "")
    XCTAssert(brain.operators == ["+","+"])
  }
  
  // MARK: - Testing if concatenation of numbers and operands are a valid operation
  
  func testGivenStringNumbersIsEmpty_whenisExpressionCorrectTriggered_thenSendsFalse(){
    //Set stringNumbers to Empty
    brain.stringNumbers = [String()]
    XCTAssertFalse(brain.isExpressionCorrect)
  }
  
  func testGivenStringNumbersHasEmptyString_whenisExpressionCorrectTriggered_thenSendsFalse(){
    brain.stringNumbers = [""]
    XCTAssertFalse(brain.isExpressionCorrect)
  }
  
  func testGivenStringNumbersHasOneMember_whenisExpressionCorrectTriggered_thenSendsFalse(){
    brain.stringNumbers = ["1"]
    XCTAssert(brain.isExpressionCorrect)
  }
  func testGivenStringNumbersHasManyMembers_whenisExpressionCorrectTriggered_thenSendsFalse(){
    brain.stringNumbers = ["10","11"]
    XCTAssert(brain.isExpressionCorrect)
  }
  
  // MARK: - Testing CalculatorBrain calculation
  
  func testGivenTwoNumbers_whenEqualButtonIsTappedAndResultIsInteger_ThenResultIsRounded(){
    XCTAssertFalse(brain.roundEvaluation(2.5))
    XCTAssert(brain.roundEvaluation(14.0))
    
  }
  func testGivenTwoNumbersAndAnOperandIsPlus_whenEqualButtonPressed_thenBraindSendBackResult(){
    brain.stringNumbers = ["1", "2"]
    brain.operators = ["+","+"]
    XCTAssert(brain.calculateTotal() == 3)
  }
  
  func testGivenTwoNumbersAndAnOperandIsMinus_whenEqualButtonPressed_thenBraindSendBackResult(){
    brain.stringNumbers = ["10", "2"]
    brain.operators = ["+","-"]
    XCTAssert(brain.calculateTotal() == 8)
  }
  func testGivenTwoNumbersAndAnOperandIsMultiply_whenEqualButtonPressed_thenBraindSendBackResult(){
    brain.stringNumbers = ["10", "2"]
    brain.operators = ["+","x"]
    XCTAssert(brain.calculateTotal() == 20)
  }
  func testGivenTwoNumbersAndAnOperandIsDivide_whenEqualButtonPressed_thenBraindSendBackResult(){
    brain.stringNumbers = ["5", "2"]
    brain.operators = ["+","/"]
    XCTAssert(brain.calculateTotal() == 2.5)
  }
  // MARK: - Testing user can use result in a new calculation
  
  func testGivenDidACalculation_WhenEqualIsPressed_thenResultIsStored() {
      brain.stringNumbers = ["10", "2"]
      brain.operators = ["+","x"]
      _ = brain.calculateTotal()
      XCTAssert(brain.formerResult == 20.0)
    
  }
  func testGivenDidACalculation_WhenEqualIsPressed_thenUserCannAddOperator() {
    brain.stringNumbers = ["10", "2"]
    brain.operators = ["+","x"]
    _ = brain.calculateTotal()
    XCTAssert(brain.canAddOperator)
  }
  
  func testGivenAresultIsADoubleInteger_whenResultIsSentBack_thenReturnsARoundedInteger(){
    let result = 20.0
    brain.roundResult(result)
    XCTAssert(brain.stringNumbers == ["20"])
  }
  // MARK: - Testing AC function
  
  func testGivenResultIsStored_WhenACIsPressed_thenAllValuesAreReset() {
    brain.stringNumbers = ["10", "2"]
    brain.operators = ["+","x"]
    brain.formerResult = 20.0
    brain.allClear()
    XCTAssert(brain.stringNumbers == [String()])
    XCTAssert(brain.operators == ["+"])
    XCTAssert(brain.formerResult == nil)
    
    
  }
}
