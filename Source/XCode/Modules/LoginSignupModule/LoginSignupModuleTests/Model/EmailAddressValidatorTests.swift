//
//  EmailAddressValidatorTests.swift
//  LoginSignupModuleTests
//
//  Created by Christian Slanzi on 25.04.21.
//

import XCTest
@testable import LoginSignupModule

class EmailAddressValidatorTests: XCTestCase {
    
    fileprivate let emptyString = ""
    
    fileprivate let validEmailAddress1 = "a@b.com"
    fileprivate let validEmailAddress2 = "a@b.co.uk"
    fileprivate let validEmailAddress3 = "a@b.io"
    fileprivate let validEmailAddress4 = "andrew.shaw@byteowl.io"
    
    fileprivate let invalidEmailAddress1 = "ab.com"
    fileprivate let invalidEmailAddress2 = "abcom"
    fileprivate let invalidEmailAddress3 = "a@b@com"

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

// MARK: Empty string validation
extension EmailAddressValidatorTests {
    
    func testValidate_EmptyString_ReturnsFalse() {
        let validator = EmailAddressValidator()
        XCTAssertFalse(validator.validate(emptyString), "string can not be empty.")
    }
    
}

// MARK: invalid email-addresses
extension EmailAddressValidatorTests {
    
    func testValidate_InvalidEmailAddress1_ReturnsFalse() {
        let validator = EmailAddressValidator()
        XCTAssertFalse(validator.validate(invalidEmailAddress1), "/(invalidEmailAddress1) is not a valid e-mail address.")
    }
    
    func testValidate_InvalidEmailAddress2_ReturnsFalse() {
        let validator = EmailAddressValidator()
        XCTAssertFalse(validator.validate(invalidEmailAddress2), "/(invalidEmailAddress2) is not a valid e-mail address.")
    }
    
    func testValidate_InvalidEmailAddress3_ReturnsFalse() {
        let validator = EmailAddressValidator()
        XCTAssertFalse(validator.validate(invalidEmailAddress3), "/(invalidEmailAddress3) is not a valid e-mail address.")
    }
    
}


// MARK: valid email-addresses
extension EmailAddressValidatorTests {
    
    func testValidate_ValidEmailAddress1_ReturnsTrue() {
        let validator = EmailAddressValidator()
        XCTAssertTrue(validator.validate(validEmailAddress1), "/(validEmailAddress1) is a valid e-mail address.")
    }
    
    func testValidate_ValidEmailAddress2_ReturnsTrue() {
        let validator = EmailAddressValidator()
        XCTAssertTrue(validator.validate(validEmailAddress2), "/(validEmailAddress2) is a valid e-mail address.")
    }
    
    func testValidate_ValidEmailAddress3_ReturnsTrue() {
        let validator = EmailAddressValidator()
        XCTAssertTrue(validator.validate(validEmailAddress3), "/(validEmailAddress3) is a valid e-mail address.")
    }
    
    func testValidate_ValidEmailAddress4_ReturnsTrue() {
        let validator = EmailAddressValidator()
        XCTAssertTrue(validator.validate(validEmailAddress4), "/(validEmailAddress4) is a valid e-mail address.")
    }
    
}
