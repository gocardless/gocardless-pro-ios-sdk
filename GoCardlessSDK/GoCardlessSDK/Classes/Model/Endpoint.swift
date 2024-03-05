//
//  Endpoint.swift
//  GoCardlessSDK
//
//  Created by Gunhan Sancar on 25/01/2024.
//

import Foundation

enum Endpoint {
    case customerList
    case customerRemove(customerId: String)
    case billingRequestCreate
    case billingRequestFlowCreate
    
    var path: String {
        switch self {
        case .customerList: return "/customers"
        case .customerRemove(let customerId): return "/customers/\(customerId)"
        case .billingRequestCreate: return "/billing_requests"
        case .billingRequestFlowCreate: return "/billing_request_flows"
        }
    }
    
    var method: String {
        switch self {
        case .customerList: return "GET"
        case .customerRemove: return "DELETE"
        case .billingRequestCreate, .billingRequestFlowCreate: return "POST"
        }
    }
}

extension Endpoint {
    func url(environment: Environment) -> URL? {
        URLRequest(environemnt: environment, endpoint: self).url
    }
}

/// Initializes a `URLRequest` instance with the specified `Endpoint`.
///
/// - Parameter endpoint: The `Endpoint` to use for the request.
extension URLRequest {
    init(environemnt: Environment, endpoint: Endpoint) {
        let url = "\(environemnt.baseUrl)\(endpoint.path)"
        self.init(url: URL(string: url)!)
        self.httpMethod = endpoint.method
    }
}
