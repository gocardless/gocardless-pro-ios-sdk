//
//  BillingRequestService.swift
//  GoCardlessSDK
//
//

import Foundation
import Combine

/**
 * A Billing Request enables you to collect all types of GoCardless payments using
 * the Billing Request Flow API. This includes both one-off and recurring payments
 * from your new or existing customers.
 */
public class BillingRequestService {
    private let httpClient: HttpClient
    
    init(httpClient: HttpClient) {
        self.httpClient = httpClient
    }
    
    /**
     Creates a Billing Request, enabling you to collect all types of GoCardless payments using
     the Billing Request Flow API. This includes both one-off and recurring payments
     from your new or existing customers.
     
     - Parameter billingRequest: The Billing Request to create.
     */
    public func createBillingRequest(billingRequest: BillingRequest) -> AnyPublisher<BillingRequest, Error> {
        let endpoint = Endpoint.billingRequestCreate
        
        return httpClient.request(endpoint: endpoint)
            .decode(type: BillingRequestWrapper.self, decoder: JSONDecoder())
            .map { $0.billingRequests ?? billingRequest }
            .eraseToAnyPublisher()
    }
}
