//
//  HTTPClientSpy.swift
//  UserApiServiceTests
//
//  Created by Christian Slanzi on 23.04.21.
//

import XCTest
import NetworkingService

class HTTPClientSpy: HTTPClient {
    
    private var messages = [(url: URL, completion: (HTTPClientResult) -> Void)]()
    
    var requestedURLs: [URL] {
        return messages.map { $0.url }
    }
    
    var requestHttpHeaders: HTTPClientEntity = HTTPClientEntity()
    var urlQueryParameters: HTTPClientEntity = HTTPClientEntity()
    var httpBodyParameters: HTTPClientEntity = HTTPClientEntity()
    
    func makeRequest(toURL url: URL, withHttpMethod httpMethod: HTTPMethod, completion: @escaping (HTTPClientResult) -> Void) {
        messages.append((url, completion))
    }
    
    func getData(fromURL url: URL, completion: @escaping (Data?) -> Void) {
        
    }
    
    func complete(with error: Error, at index: Int = 0, file: StaticString = #file, line: UInt = #line) {
        guard messages.count > index else {
            return XCTFail("Can't complete request never made", file: file, line: line)
        }

        messages[index].completion(HTTPClientResult(withError: error))
    }
    
    func complete(withStatusCode code: Int, data: Data, at index: Int = 0, file: StaticString = #file, line: UInt = #line) {
        guard requestedURLs.count > index else {
            return XCTFail("Can't complete request never made", file: file, line: line)
        }
        
        let response = HTTPURLResponse(
            url: requestedURLs[index],
            statusCode: code,
            httpVersion: nil,
            headerFields: nil
        )!
        
        messages[index].completion(HTTPClientResult(withData: data, response: HTTPClientResponse(fromURLResponse: response), error: nil))
    }
    
}