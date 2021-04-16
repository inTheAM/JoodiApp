//
//  SubmitReviewViewModelTests.swift
//  JoodiAppTests
//
//  Created by Ahmed Mgua on 4/16/21.
//

import XCTest
@testable import JoodiApp

class SubmitReviewViewModelTests: XCTestCase {
	var sut:	SubmitReviewViewModel!
	
	override func setUpWithError()	throws {
		super.setUp()
		sut	=	SubmitReviewViewModel(for: .blank)
	}
	
	override func tearDownWithError() throws {
		sut	=	nil
	}
	
	func testOrdersListFetched()	throws	{
		let exp	=	expectation(description: "Submitting review")
		sut.submitReview	{
			exp.fulfill()
		}
		waitForExpectations(timeout: 5)
		
		XCTAssertEqual(sut.submitStatus, .success)
	}
}
