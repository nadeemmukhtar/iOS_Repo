//
//  testAppTests.swift
//  testAppTests
//
//  Created by Developer on 12/2/16.
//  Copyright © 2016 test. All rights reserved.
//

import XCTest
@testable import testApp

class testAppTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testinit() {
        let dm = MainListingModelDefault()
        let vm = MainListingViewModel(dataModel: dm)
        XCTAssertTrue(vm.dataModel === dm)
    }
    
    func testAPIFetch() {
        let dm = MainListingModelDefault()
        let expectation = self.expectation(description: "Wait for async operation")
        dm.fetchObjects()
        dm.objectDataChangeHandler = { () in
            XCTAssertNotNil(dm.allObjects)
            XCTAssertGreaterThan(dm.allObjects.count, 0, "object returned should be greater than 0")
            expectation.fulfill()
        }
        
        self.waitForExpectations(timeout: 25, handler: nil)
        
    }
    
    func testSearchFunctionality() {
        let dm = MainListingModelDefault()
        let expectation = self.expectation(description: "Wait for async operation")
        dm.fetchObjects()
        dm.objectDataChangeHandler = { () in
            
            dm.objectDataChangeHandler = nil
            // filter on first object
            dm.searchKeyChanged(searchKey: dm.allObjects[0].name!)
            
            // now check filter results contains at leat first object
            XCTAssertGreaterThan(dm.filteredObjects.count, 0, "There should be at least one object filtered")
            expectation.fulfill()
        }
        
        self.waitForExpectations(timeout: 25, handler: nil)
    }
    
}
