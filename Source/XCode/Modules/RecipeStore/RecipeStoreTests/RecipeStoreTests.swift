//
//  RecipeStoreTests.swift
//  RecipeStoreTests
//
//  Created by Christian Slanzi on 05.05.21.
//

import XCTest
import CoreData
import TestHelpers
@testable import RecipeStore

class RecipeStoreTests: XCTestCase {

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

extension RecipeStoreTests {
    
    // - MARK: Helpers
    
    private func makeSUT(file: StaticString = #filePath, line: UInt = #line) throws -> RecipeStore {
        let inMemoryStoreURL = URL(fileURLWithPath: "/dev/null")
        let sut = try CoreDataRecipeStore(storeURL: inMemoryStoreURL)
        trackForMemoryLeaks(sut, file: file, line: line)
        return sut
    }
}