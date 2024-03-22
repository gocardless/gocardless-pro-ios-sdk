//
//  Endpoint.swift
//  GoCardlessSDK
//
//  Created by Gunhan Sancar on 25/01/2024.
//

import Foundation

/// Represent different API endpoints.
enum Endpoint {
    case customerList
    case customerRemove(customerId: String)
    case billingRequestCreate(body: BillingRequestWrapper)
    case billingRequestFlowCreate(body: BillingRequestFlowWrapper)
    case actionCollectCustomerDetails(billingRequestId: String, body: GenericRequest<CollectCustomerDetailsRequest>)
    case actionCollectBankAccount(billingRequestId: String, body: GenericRequest<CollectBankAccount>)
    case actionConfirmPayerDetails(billingRequestId: String, body: GenericRequest<ConfirmPayerDetailsRequest>)
    case actionFulfil(billingRequestId: String, body: GenericRequest<Metadata>?)
    case actionCancel(billingRequestId: String, body: GenericRequest<Metadata>?)
    case actionNotify(billingRequestId: String, body: GenericRequest<Metadata>?)
    
    /// The relative URL path associated with each endpoint.
    var path: String {
        switch self {
        case .customerList: 
            return "/customers"
        case .customerRemove(let customerId):
            return "/customers/\(customerId)"
        case .billingRequestCreate:
            return "/billing_requests"
        case .billingRequestFlowCreate:
            return "/billing_request_flows"
        case .actionCollectCustomerDetails(let billingRequestId, _):
            return "/billing_requests/\(billingRequestId)/actions/collect_customer_details"
        case .actionCollectBankAccount(let billingRequestId, _):
            return "/billing_requests/\(billingRequestId)/actions/collect_bank_account"
        case .actionConfirmPayerDetails(let billingRequestId, _):
            return "/billing_requests/\(billingRequestId)/actions/confirm_payer_details"
        case .actionFulfil(let billingRequestId, _):
            return "/billing_requests/\(billingRequestId)/actions/fulfil"
        case .actionCancel(let billingRequestId, _):
            return "/billing_requests/\(billingRequestId)/actions/cancel"
        case .actionNotify(let billingRequestId, _):
            return "/billing_requests/\(billingRequestId)/actions/notify"
        }
    }
    
    /// The HTTP method associated with each endpoint.
    var method: String {
        switch self {
        case .customerList: 
            return "GET"
        case .customerRemove:
            return "DELETE"
        default:
            return "POST"
        }
    }
    
    /// Body of the HTTP request
    var body: Encodable? {
        switch self {
        case .billingRequestCreate(let body): return body
        case .billingRequestFlowCreate(let body): return body
        case .actionCollectCustomerDetails(_, let body): return body
        case .actionCollectBankAccount(_, let body): return body
        case .actionConfirmPayerDetails(_, let body): return body
        default: return nil
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
