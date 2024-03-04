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
    
    public func all(completion: @escaping ((Result<Customers, Error>) -> Void)) {
        let endpoint = Endpoint.customerList
        
        httpClient.request(endpoint: endpoint) { result in
            switch result {
            case .success(let data):
                print(String(data: data, encoding: .utf8)!)
                do {
                    let items = try JSONDecoder().decode(Customers.self, from: data)
                    completion(.success(items))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    // Combine
    public func all() -> AnyPublisher<Customers, Error> {
        print(" CustomerService > all" )
        let endpoint = Endpoint.customerList
        
        // improve error handling
        return httpClient.request(endpoint: endpoint)
            .decode(type: Customers.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    public func delete(customerId: String) -> AnyPublisher<Data, Error> {
        print(" CustomerService > delete" )
        let endpoint = Endpoint.customerRemove(customerId: customerId)
        
        return httpClient.request(endpoint: endpoint)
            .eraseToAnyPublisher()
    }
}
