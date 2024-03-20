//
//  URLProtocolStub.swift
//  GoCardlessSDK
//
//

import XCTest
import Combine
@testable import GoCardlessSDK

typealias StubBundle = (error: Error?, data: Data?, response: HTTPURLResponse?)

class URLProtocolStub: URLProtocol {
    static var testURLs = [URL?: StubBundle]()
    
    static func successStub(endpoint: Endpoint, fileName: String) {
        let url = endpoint.url(environment: TestConstants.environment)!
        print(" successStub.url: \(url)")
        let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)
        let bundle = StubBundle(nil, TestFileManager.loadFile(name: fileName)!, response)
        
        URLProtocolStub.testURLs = [endpoint.url(environment: TestConstants.environment)!: bundle]
    }
    
    static func errorStub(endpoint: Endpoint, fileName: String) {
        let url = endpoint.url(environment: TestConstants.environment)!
        let response = HTTPURLResponse(url: url, statusCode: 400, httpVersion: nil, headerFields: nil)
        let bundle = StubBundle(nil, TestFileManager.loadFile(name: fileName)!, response)
        
        URLProtocolStub.testURLs = [endpoint.url(environment: TestConstants.environment)!: bundle]
    }
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }

    override func startLoading() {
        if let url = request.url, let bundle = Self.testURLs[url] {
            if let response = bundle.response {
                client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            }
            
            if let data = bundle.data {
                client?.urlProtocol(self, didLoad: data)
            }
        } else {
            let error = NSError(domain: "", 
                                code: 999,
                                userInfo: [NSLocalizedDescriptionKey: "Couldn't find response for \(request.url?.absoluteString ?? "")"])
            client?.urlProtocol(self, didFailWithError: error)
        }
        
        client?.urlProtocolDidFinishLoading(self)
    }

    override func stopLoading() {}
}
