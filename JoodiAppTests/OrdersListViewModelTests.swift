//
//  OrdersListViewModelTests.swift
//  JoodiAppTests
//
//  Created by Ahmed Mgua on 4/16/21.
//

import XCTest
@testable import JoodiApp

class OrdersListViewModelTests: XCTestCase {
	var sut:	OrdersListViewModel!
	
	override func setUpWithError()	throws {
		super.setUp()
		sut	=	OrdersListViewModel()
	}
	
	override func tearDownWithError() throws {
		sut	=	nil
	}
	
	func testOrdersListFetched()	throws	{
		let exp	=	expectation(description: "Fetching orders list")
		sut.fetch	{
			exp.fulfill()
		}
		waitForExpectations(timeout: 5)
		
		XCTAssertEqual(sut.fetchingStatus, .success)
	}
}
