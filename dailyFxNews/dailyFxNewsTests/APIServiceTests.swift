//
//  APIServiceTests.swift
//  dailyFxNewsTests
//
//  Created by raja padala on 07/11/21.
//

import XCTest
@testable import dailyFxNews

class APIServiceTests: XCTestCase {
    
    var service: APIService<Any>?
    
    override func setUp() {
        super.setUp()
        service = APIService()
    }
    
    override func tearDown() {
        service = nil
        super.tearDown()
    }
    
    func test_fetch_news() {
        let service = self.service!
        let expect = XCTestExpectation(description: "callback")
        service.fetch(model: DailyFxNews.self, urlString: AppUrls.sourceUrl) { model, error, errorCode in
            
            // Make sure we downloaded some data.
            XCTAssertNotNil(model, "No data was downloaded.")
            
            // Fulfill the expectation to indicate that the background task has finished successfully
            expect.fulfill()
        }
        
        wait(for: [expect], timeout: 10.0)
    }

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
