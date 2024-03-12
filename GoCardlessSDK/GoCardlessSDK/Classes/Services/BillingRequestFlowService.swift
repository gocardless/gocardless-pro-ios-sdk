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
    
    public func createBillingRequestFlow(billingRequestFlow: BillingRequestFlow) -> AnyPublisher<BillingRequestFlow, Error> {
        let endpoint = Endpoint.billingRequestFlowCreate
        
        return httpClient.request(endpoint: endpoint)
            .decode(type: BillingRequestFlowWrapper.self, decoder: JSONDecoder())
            .map { $0.billingRequestFlows ??  billingRequestFlow }
            .eraseToAnyPublisher()
    }
}
