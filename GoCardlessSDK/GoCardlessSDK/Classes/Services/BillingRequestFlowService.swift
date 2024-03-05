//
//  BillingRequestFlowService.swift
//  GoCardlessSDK
//
//

import Foundation
import Combine

public class BillingRequestFlowService {
    private let httpClient: HttpClient
    
    init(httpClient: HttpClient) {
        self.httpClient = httpClient
    }
    
    public func createBillingRequestFlow(billingRequest: BillingRequest) -> AnyPublisher<BillingRequest, Error> {
        let endpoint = Endpoint.billingRequestCreate
        
        return httpClient.request(endpoint: endpoint)
            .decode(type: BillingRequestWrapper.self, decoder: JSONDecoder())
            .map { $0.billingRequests ??  billingRequest }
            .eraseToAnyPublisher()
    }
}
