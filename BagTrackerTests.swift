//
//  BagTrackerTests.swift
//  BagTrackerTests
//
//  Created by 韩猷 on 9/30/16.
//  Copyright © 2016 Apple Inc. All rights reserved.
//

import XCTest
@testable import BagTracker

class BagTrackerTests: XCTestCase {
    
    // MARK: FoodTracker Tests
    
    // Tests to confirm that the Meal initializer returns when no name or a negative rating is provided.
    func testMealInitialization() {
        
        // Success case.
        let potentialItem = Bag(name: "Newest bag", photo: nil, rating: 5)
        XCTAssertNotNil(potentialItem)
        
        // Failure cases.
        let noName = Bag(name: "", photo: nil, rating: 0)
        XCTAssertNil(noName, "Empty name is invalid")
        
        let badRating = Bag(name: "Really bad rating", photo: nil, rating: -1)
        XCTAssertNil(badRating, "Negative ratings are invalid, be positive")

    }
    

    
}
