//
//  Endpoint.swift
//  GoCardlessSDK
//
//  Created by Gunhan Sancar on 25/01/2024.
//

import Foundation

/// Represent different API endpoints.
enum Endpoint {
    case bankAuthorisationCreate(body: BankAuthorisationWrapper)
    case billingRequestCreate(body: BillingRequestWrapper)
    case billingRequestGet(billingRequestId: String)
    case billingRequestList
    case billingRequestFlowCreate(body: BillingRequestFlowWrapper)
    case actionCollectCustomerDetails(billingRequestId: String, body: GenericRequest<CollectCustomerDetailsRequest>)
    case actionCollectBankAccount(billingRequestId: String, body: GenericRequest<CollectBankAccount>)
    case actionConfirmPayerDetails(billingRequestId: String, body: GenericRequest<ConfirmPayerDetailsRequest>)
    case actionSelectInstitution(billingRequestId: String, body: GenericRequest<SelectInstitution>?)
    case actionFulfil(billingRequestId: String, body: GenericRequest<Metadata>?)
    case actionCancel(billingRequestId: String, body: GenericRequest<Metadata>?)
    case actionNotify(billingRequestId: String, body: GenericRequest<NotifyRequest>?)
    case paymentCreate(payment: PaymentWrapper)
    case paymentGet(paymentId: String)
    
    /// The relative URL path associated with each endpoint.
    var path: String {
        switch self {
        case .bankAuthorisationCreate:
            return "/bank_authorisations"
        case .billingRequestCreate:
            return "/billing_requests"
        case .billingRequestGet(let billingRequestId):
            return "/billing_requests/\(Endpoint.escapePathParam(billingRequestId))"
        case .billingRequestList:
            return "/billing_requests"
        case .billingRequestFlowCreate:
            return "/billing_request_flows"
        case .actionCollectCustomerDetails(let billingRequestId, _):
            return "/billing_requests/\(Endpoint.escapePathParam(billingRequestId))/actions/collect_customer_details"
        case .actionCollectBankAccount(let billingRequestId, _):
            return "/billing_requests/\(Endpoint.escapePathParam(billingRequestId))/actions/collect_bank_account"
        case .actionConfirmPayerDetails(let billingRequestId, _):
            return "/billing_requests/\(Endpoint.escapePathParam(billingRequestId))/actions/confirm_payer_details"
        case .actionFulfil(let billingRequestId, _):
            return "/billing_requests/\(Endpoint.escapePathParam(billingRequestId))/actions/fulfil"
        case .actionCancel(let billingRequestId, _):
            return "/billing_requests/\(Endpoint.escapePathParam(billingRequestId))/actions/cancel"
        case .actionNotify(let billingRequestId, _):
            return "/billing_requests/\(Endpoint.escapePathParam(billingRequestId))/actions/notify"
        case .actionSelectInstitution(let billingRequestId, _):
            return "/billing_requests/\(Endpoint.escapePathParam(billingRequestId))/actions/select_institution"
        case .paymentCreate(_):
            return "/payments"
        case .paymentGet(let paymentId):
            return "/payments/\(Endpoint.escapePathParam(paymentId))"
        }
    }
    
    /// The HTTP method associated with each endpoint.
    var method: String {
        switch self {
        case .billingRequestGet, .billingRequestList, .paymentGet:
            return "GET"
        default:
            return "POST"
        }
    }
    
    /// Body of the HTTP request in the `Encodable` format
    var body: Encodable? {
        switch self {
        case .bankAuthorisationCreate(let body): return body
        case .billingRequestCreate(let body): return body
        case .billingRequestFlowCreate(let body): return body
        case .actionCollectCustomerDetails(_, let body): return body
        case .actionCollectBankAccount(_, let body): return body
        case .actionConfirmPayerDetails(_, let body): return body
        case .actionSelectInstitution(_, let body): return body
        case .actionNotify(_, let body): return body
        case .paymentCreate(let body): return body
        default: return nil
        }
    }

    /// Percent-encodes a path parameter so a caller-supplied identifier
    /// cannot alter the request path. Path separators ("/"), dot-segments
    /// ("." / "..") and query/fragment markers ("?" / "#") are escaped.
    /// Control characters are rejected before URL creation.
    static func escapePathParam(_ value: String) -> String {
        let allowed = CharacterSet(charactersIn:
            "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-_~")
        return value.addingPercentEncoding(withAllowedCharacters: allowed) ?? ""
    }

    var hasControlCharacterInPathParam: Bool {
        switch self {
        case .billingRequestGet(let value),
             .actionCollectCustomerDetails(let value, _),
             .actionCollectBankAccount(let value, _),
             .actionConfirmPayerDetails(let value, _),
             .actionSelectInstitution(let value, _),
             .actionFulfil(let value, _),
             .actionCancel(let value, _),
             .actionNotify(let value, _),
             .paymentGet(let value):
            return value.unicodeScalars.contains { CharacterSet.controlCharacters.contains($0) }
        default:
            return false
        }
    }
}

extension Endpoint {
    func url(environment: Environment) -> URL? {
        URLRequest(environemnt: environment, endpoint: self)?.url
    }
}

/// Initializes a `URLRequest` instance with the specified `Endpoint`.
///
/// - Parameter endpoint: The `Endpoint` to use for the request.
extension URLRequest {
    init?(environemnt: Environment, endpoint: Endpoint) {
        guard !endpoint.hasControlCharacterInPathParam else {
            return nil
        }
        let urlString = "\(environemnt.baseUrl)\(endpoint.path)"
        guard let url = URL(string: urlString) else {
            return nil
        }
        self.init(url: url)
        self.httpMethod = endpoint.method
    }
}
