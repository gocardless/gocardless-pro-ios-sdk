//
//  CustomerService.swift
//  GoCardlessSDK
//
//  Created by Gunhan Sancar on 25/01/2024.
//

import Foundation
import Combine

public class CustomerService {
    private let httpClient: HttpClient
    
    init(httpClient: HttpClient) {
        self.httpClient = httpClient
    }
    
    public func all() -> AnyPublisher<Customers, Error> {
        print(" CustomerService > all" )
        let endpoint = Endpoint.customerList
        
        // improve error handling
        return httpClient.request(endpoint: endpoint)
            .decode(type: Customers.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    public func delete(customerId: String) -> AnyPublisher<Data, APIError> {
        print(" CustomerService > delete" )
        let endpoint = Endpoint.customerRemove(customerId: customerId)
        
        return httpClient.request(endpoint: endpoint)
            .eraseToAnyPublisher()
    }
}
