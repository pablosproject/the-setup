//
//  NetworkIntegrationTests.swift
//  TheSetup
//
//  Created by Paolo Tagliani on 17/02/2017.
//  Copyright © 2017 Pablosproject. All rights reserved.
//

import XCTest

class NetworkIntegrationTests: XCTestCase {
    
    override func setUp() {
        super.setUp()

    }
    
    override func tearDown() {

        super.tearDown()
    }

	//Simple integration testing
    func testInterviewListintegration () {
		let expectation = self.expectation(description: "interviewList")
        NetworkService.interviewList { interviews in
			if let interviews = interviews {
				XCTAssert(interviews.count != 0)
			}
			else {
				XCTFail()
			}
			expectation.fulfill()
		}
		
		self.waitForExpectations(timeout: 10, handler: nil)
    }
}
