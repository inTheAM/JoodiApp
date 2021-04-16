//
//  OrderDetailsViewModelTests.swift
//  JoodiAppTests
//
//  Created by Ahmed Mgua on 4/16/21.
//

import XCTest
@testable import JoodiApp

class OrderDetailstViewModelTests: XCTestCase {
	var sut:	OrderDetailsViewModel!
	
	override func setUpWithError()	throws {
		super.setUp()
		sut	=	OrderDetailsViewModel()
	}
	
	override func tearDownWithError() throws {
		sut	=	nil
	}
	
	func testOrdersListFetched()	throws	{
		let exp	=	expectation(description: "Fetching order details")
		sut.fetch(1)	{
			exp.fulfill()
		}
		waitForExpectations(timeout: 5)
		
		XCTAssertEqual(sut.fetchingStatus, .success)
	}
}
