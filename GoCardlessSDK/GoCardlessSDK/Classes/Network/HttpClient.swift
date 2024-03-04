//
//  HttpClient.swift
//  GoCardlessSDK
//
//  Created by Gunhan Sancar on 25/01/2024.
//

import Foundation
import Combine

class HttpClient {
    private let httpHeaderProvider: HttpHeaderProvider
    private let envrionment: Environment
    
    init(httpHeaderProvider: HttpHeaderProvider, envrionment: Environment) {
        self.httpHeaderProvider = httpHeaderProvider
        self.envrionment = envrionment
    }
    
    // Completion blocks
    func request(endpoint: Endpoint, result: @escaping ((Result<Data, Error>) -> Void)) {
        let request = URLRequest(environemnt: envrionment, endpoint: endpoint)
            .setHeaders(provider: httpHeaderProvider)
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                result(.failure(APIError.notFound))
                return
            }
            
            if let error = error {
                result(.failure(error))
                return
            }
            
            result(.success(data))
        }
        
        task.resume()
    }
    
    // Combine
    func request(endpoint: Endpoint) -> AnyPublisher<Data, Error> {
        let request = URLRequest(environemnt: envrionment, endpoint: endpoint)
            .setHeaders(provider: httpHeaderProvider)
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode) else {
                    throw APIError.notFound
                }
                print(" RESPONSE: \n\(String(data: data, encoding: .utf8)!)")
                return data
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
