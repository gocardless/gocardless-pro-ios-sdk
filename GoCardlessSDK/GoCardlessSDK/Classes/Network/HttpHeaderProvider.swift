//
//  HttpHeaderProvider.swift
//  GoCardlessSDK
//
//  Created by Gunhan Sancar on 25/01/2024.
//

import Foundation

/// Adds custom headers to the API requests
///
/// This provider adds the following headers:
/// - "GoCardless-Version": Specifies the GoCardless API version (e.g., "2015-07-06").
/// - "Authorization": Includes the access token in the format "Bearer {accessToken}".
class HttpHeaderProvider {
    private let accessToken: String
    
    init(accessToken: String) {
        self.accessToken = accessToken
    }
    
    func setHeader(request: URLRequest) -> URLRequest {
        var request = request
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("2015-07-06", forHTTPHeaderField: "GoCardless-Version")
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        return request
    }
}

extension URLRequest {
    func setHeaders(provider: HttpHeaderProvider) -> URLRequest {
        provider.setHeader(request: self)
    }
}
