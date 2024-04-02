//
//  BillingRequestFlowService.swift
//  GoCardlessSDK
//
//

import Foundation
import Combine

/**
 * Billing Request Flows can be created to enable a payer to authorise a payment
 * created for a scheme with strong payer authorisation (such as open banking single payments).
 */
public class BillingRequestFlowService {
    private let httpClient: HttpClient
    
    init(httpClient: HttpClient) {
        self.httpClient = httpClient
    }
    
    /// Creates a new billing request flow.
    public func createBillingRequestFlow(billingRequestFlow: BillingRequestFlow) -> AnyPublisher<BillingRequestFlow, APIError> {
        let endpoint = Endpoint.billingRequestFlowCreate(body: BillingRequestFlowWrapper(billingRequestFlows: billingRequestFlow))
        
        return httpClient.request(endpoint: endpoint)
            .decode(type: BillingRequestFlowWrapper.self, decoder: JSONDecoder())
            .map { $0.billingRequestFlows ??  billingRequestFlow }
            .mapAPIError()
            .eraseToAnyPublisher()
    }
}
