//
//  TestAppTests.swift
//  TestAppTests
//
//  Created by DGV on 08/03/20.
//  Copyright © 2020 Dipen. All rights reserved.
//

import XCTest
@testable import CountryFinder

class CountryFinderTests: XCTestCase {
    
    var vc: CountryTableViewController = CountryTableViewController()

    func testGetCountryWithApiCall() {
        
        let e = expectation(description: "Alamofire")
        let apiRespository = webserviceManager()
        apiRespository.requestFetchCountry(with: "India", completion: { ModelSearchCountry, error in
            
            debugPrint("Finished in unit test!!!")
            debugPrint("----> Unit Test Login Data \(ModelSearchCountry?[1].name ?? "")")
            let resultString = ModelSearchCountry?[1].name ?? ""
            let expectedString = "India"
            XCTAssertEqual(resultString, expectedString)
            e.fulfill()

        })
        waitForExpectations(timeout: 5.0, handler: nil)

    }

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
