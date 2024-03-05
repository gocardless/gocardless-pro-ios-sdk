//
//  BillingRequestService.swift
//  GoCardlessSDK
//
//

import Foundation
import Combine

public class BillingRequestService {
    private let httpClient: HttpClient
    
    init(httpClient: HttpClient) {
        self.httpClient = httpClient
    }
    
    public func createBillingRequest(billingRequest: BillingRequest) -> AnyPublisher<BillingRequest, Error> {
        let endpoint = Endpoint.billingRequestCreate
        
        return httpClient.request(endpoint: endpoint)
            .decode(type: BillingRequestWrapper.self, decoder: JSONDecoder())
            .map { $0.billingRequests ??  billingRequest }
            .eraseToAnyPublisher()
    }
}
