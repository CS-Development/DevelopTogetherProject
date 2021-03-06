//
//  LoginModelTests.swift
//  LoginSignupModuleTests
//
//  Created by Christian Slanzi on 21.03.21.
//

import XCTest
@testable import LoginSignupModule

class LoginModelTests: XCTestCase {
    
    private let validDummyUserName: String = "username"
    private let validDummyPassword: String = "Aryb4N79"
    private let invalidDummyUserName: String = "u%"
    private let invalidDummyPassword: String = "abc"
    private let emptyDummyUserName: String = ""
    private let emptyDummyPassword: String = ""

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
    
    func testLoginModel_ValidUserName_ValidPassword_CanBeInstantiated() {
       let loginModel = LoginModel(userName: validDummyUserName,
                                   password: validDummyPassword)
       XCTAssertNotNil(loginModel)
    }
    
    func testLoginModel_InvalidUserName_ValidPassword_CanNotBeInstantiated() {
      let loginModel = LoginModel(userName: invalidDummyUserName,
                                  password: validDummyPassword)
      XCTAssertNil(loginModel)
    }

}
