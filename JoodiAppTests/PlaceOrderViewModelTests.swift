//
//  PlaceOrderViewModelTests.swift
//  JoodiAppTests
//
//  Created by Ahmed Mgua on 4/16/21.
//

import XCTest

@testable import JoodiApp

class	PlaceOrderViewModelTests:	XCTestCase	{
	var sut:	PlaceOrderViewModel!
	
	override func setUpWithError()	throws {
		super.setUp()
		sut	=	PlaceOrderViewModel()
	}
	
	override func tearDownWithError() throws {
		sut	=	nil
	}
	
	func testNewItemIsAdded()	throws	{
		sut.newItem	=	Item(name: "New Item", count: 1)
		sut.addNewItem()
		XCTAssertEqual(sut.items.count, 1)
	}

	
	func testPlaceEmptyOrder()	throws	{
		sut.placeOrder()
		XCTAssert(sut.submitStatus	==	.invalidInputs)
	}
	
	func testPlaceOrder()	throws	{
		sut.newItem	=	Item(name: "New Item", count: 1)
		sut.addNewItem()
		sut.name	=	"Ahmed"
		sut.phoneNumber	=	"000000"
		sut.timeToDeliver	=	Date()
		sut.shopper	=	nil
		sut.location	=	Location.example
		
		let exp	=	expectation(description: "Placing order")
		sut.placeOrder	{
			exp.fulfill()
		}
		waitForExpectations(timeout: 5)
		
		
		XCTAssert(sut.submitStatus	==	.success)
	}
	
	func testLocationUpdated()	throws	{
		sut.location	=	Location.example
		XCTAssertNotNil(sut.location)
	}
	
	func testLocationReset()	throws	{
		sut.location	=	Location.example
		sut.resetLocation()
		XCTAssertNil(sut.location)
	}
	
	
	
	
	
}
