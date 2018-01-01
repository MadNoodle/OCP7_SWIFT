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
  
  func testGivenStringNumbersContainsManyChars_whenAddNumberIsTriggered_thenSendsTrue(){
    //Set stringNumbers to Empty
    brain.stringNumbers = ["10000000"]
    XCTAssert(brain.canAddOperator)
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
    //Set stringNumbers to Empty
    brain.stringNumbers = ["10","11"]
    XCTAssert(brain.isExpressionCorrect)
  }
  
  // MARK: - Testing CalculatorBrain calculation
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
}
