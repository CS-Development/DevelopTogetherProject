//
//  MockLoginController.swift
//  LoginSignupModuleTests
//

import Foundation
import XCTest
@testable import LoginSignupModule

class MockLoginController: LoginController {
    
    private var expectation: XCTestExpectation?
    private var expectedUserName: String?
    private var expectedPassword: String?
    
    var shouldReturnTrueOnLogin: Bool
    
    init(_ expectation: XCTestExpectation,
         expectedUserName: String,
         expectedPassword: String) {
        
        self.expectation = expectation
        self.expectedUserName = expectedUserName
        self.expectedPassword = expectedPassword
        self.shouldReturnTrueOnLogin = false
        
        super.init(delegate: nil)
    }
    
    override func doLogin(model: LoginModel) {
        
        if let expectation = self.expectation,
           let expectedUserName = self.expectedUserName,
           let expectedPassword = expectedPassword {
            if ((model.userName.compare(expectedUserName) == .orderedSame)
                    && (model.password.compare(expectedPassword) == .orderedSame)) {
                expectation.fulfill()
            }
        }
        loginControllerDelegate?.loginResult(result: shouldReturnTrueOnLogin)
    }
}
