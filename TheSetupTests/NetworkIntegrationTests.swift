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
    func testInterviewListintegration() {
        let expectation = self.expectation(description: "interviewList")
        NetworkService.interviewList { interviews in
            if let interviews = interviews {
                XCTAssert(interviews.count != 0)
            } else {
                XCTFail()
            }
            expectation.fulfill()
        }

        self.waitForExpectations(timeout: 10, handler: nil)
    }

    func testInterviewDetailIntegration() {
        let expectation = self.expectation(description: "interviewDetail")
        NetworkService.interviewDetail(slug: "matt.lubchansky") { interview in
            if let interview = interview {
                XCTAssertEqual(interview.slug, "matt.lubchansky")
                XCTAssertEqual(interview.name, "Matt Lubchansky")
                XCTAssertEqual(interview.url?.absoluteString, "https://usesthis.com/interviews/matt.lubchansky/")
                XCTAssertEqual(interview.summary, "Cartoonist (Please Listen to Me)")
                XCTAssertEqual(interview.date!, TimeInterval(1486558800))
                XCTAssertEqual(interview.categories?[0], "cartoonist")
                XCTAssert(interview.categories?.count == 2)
                XCTAssert(interview.hardware?.count == 5)
                XCTAssert(interview.software?.count == 4)
            } else {
                XCTFail()
            }
            expectation.fulfill()
        }

        self.waitForExpectations(timeout: 10, handler: nil)
    }

    func testCategoryListIntegration() {
        let expectation = self.expectation(description: "categoryList")
        NetworkService.categoriesList { categories in
            if let categories = categories {
                XCTAssert(categories.count != 0)
            } else {
                XCTFail()
            }
            expectation.fulfill()
        }

        self.waitForExpectations(timeout: 10, handler: nil)
    }

    func testCategoryDetailIntegration() {
        let expectation = self.expectation(description: "categoryDetail")
        NetworkService.categoryDetail(slug: "linux") { interviews in
            if let interviews = interviews {
                XCTAssert(interviews.count != 0)
            } else {
                XCTFail()
            }
            expectation.fulfill()
        }

        self.waitForExpectations(timeout: 10, handler: nil)
    }

    func testGearListIntegration() {
        let expectationHW = self.expectation(description: "hardwareList")
        let expectationSW = self.expectation(description: "softwareList")
        NetworkService.gearList(gearType: .hardware) { gears in
            if let gears = gears {
                XCTAssert(gears.count != 0)
            } else {
                XCTFail()
            }
            expectationHW.fulfill()
        }

        NetworkService.gearList(gearType: .software) { gears in
            if let gears = gears {
                XCTAssert(gears.count != 0)
            } else {
                XCTFail()
            }
            expectationSW.fulfill()
        }

        self.waitForExpectations(timeout: 10, handler: nil)
    }

    func testGearDetailIntegration() {
        let expectationHW = self.expectation(description: "hardwareDetail")
        let expectationSW = self.expectation(description: "softwareDetail")
        NetworkService.gearDetail(gearType: .hardware, slug: "macbook-pro") { gear in
            XCTAssertEqual(gear?.slug, "macbook-pro")
            XCTAssertEqual(gear?.name, "MacBook Pro")
            XCTAssertEqual(gear?.description, "A laptop.")
            XCTAssertEqual(gear?.url?.absoluteString, "http://www.apple.com/macbook-pro/")
            expectationHW.fulfill()
        }

        NetworkService.gearDetail(gearType: .software, slug: "photoshop") { gear in
            XCTAssertEqual(gear?.slug, "photoshop")
            XCTAssertEqual(gear?.name, "Photoshop")
            XCTAssertEqual(gear?.description, "A bitmap image editor.")
            XCTAssertEqual(gear?.url?.absoluteString, "http://www.adobe.com/products/photoshop.html")
            expectationSW.fulfill()
        }
        self.waitForExpectations(timeout: 10, handler: nil)
    }
}
