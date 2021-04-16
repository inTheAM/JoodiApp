//
//  ShoppersViewModelTests.swift
//  JoodiAppTests
//
//  Created by Ahmed Mgua on 4/16/21.
//

import XCTest

@testable import JoodiApp

class ShoppersViewModelTests:	XCTestCase	{
	var sut:	ShoppersViewModel!
	
	override func setUpWithError()	throws {
		super.setUp()
		sut	=	ShoppersViewModel()
	}
	
	override func tearDownWithError() throws {
		sut	=	nil
	}
	
	func testShoppersListFetched()	{
		let exp	=	expectation(description: "Fetching shoppers list")
		sut.fetch	{
			exp.fulfill()
		}
		waitForExpectations(timeout: 5)
		
		XCTAssertGreaterThan(sut.shoppers.count,	0)
	}
	
}
