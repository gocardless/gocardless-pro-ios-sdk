//
//  ErrorMapperTests.swift
//  GoCardlessSDK_Tests
//
//  Created by Gunhan Sancar on 02/04/2024.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import XCTest
import Combine
import Nimble
@testable import GoCardlessSDK

class ErrorMapperTests: XCTestCase {
    let errorMapper = ErrorMapper()
    let data: Data = Data()
    
    func testProcess_withValidStatusCode_shouldNotThrowError() {
        // Arrange
        let code = 200
        
        // Act & Assert
        XCTAssertNoThrow(try errorMapper.process(code: code, data: data))
    }
    
    func testProcess_with401StatusCode_shouldThrowAuthenticationError() {
        // Arrange
        let code = 401
        
        // Act & Assert
        XCTAssertThrowsError(try errorMapper.process(code: code, data: data)) { error in
            XCTAssertEqual(error as? APIError, APIError.authenticationError)
        }
    }
    
    func testProcess_with403StatusCode_shouldThrowPermissionError() {
        // Arrange
        let code = 403
        
        // Act & Assert
        XCTAssertThrowsError(try errorMapper.process(code: code, data: data)) { error in
            XCTAssertEqual(error as? APIError, APIError.permissionError)
        }
    }
    
    func testProcess_with429StatusCode_shouldThrowRateLimitError() {
        // Arrange
        let code = 429
        
        // Act & Assert
        XCTAssertThrowsError(try errorMapper.process(code: code, data: data)) { error in
            XCTAssertEqual(error as? APIError, APIError.rateLimitError)
        }
    }
    
    func testProcess_with500StatusCodeAndInvalidData_shouldThrowMalformedResponse() {
        // Arrange
        let code = 500
        let data = "InvalidData".data(using: .utf8)
        
        // Act & Assert
        XCTAssertThrowsError(try errorMapper.process(code: code, data: data!)) { error in
            XCTAssertEqual(error as? APIError, APIError.malformedResponseError)
        }
    }
}
