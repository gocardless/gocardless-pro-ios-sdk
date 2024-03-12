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
    private let urlSession: URLSession
    
    init(httpHeaderProvider: HttpHeaderProvider,
         envrionment: Environment,
         urlSession: URLSession = URLSession.shared) {
        self.httpHeaderProvider = httpHeaderProvider
        self.envrionment = envrionment
        self.urlSession = urlSession
    }
    
    func request(endpoint: Endpoint) -> AnyPublisher<Data, Error> {
        let request = URLRequest(environemnt: envrionment, endpoint: endpoint)
            .setHeaders(provider: httpHeaderProvider)
        print(" MAKE request for \(endpoint.path)")
        return urlSession.dataTaskPublisher(for: request)
            .tryMap { data, response in
                print(" RESPONSE tryMap:")
                print(" RESPONSE.data: \n\(String(data: data, encoding: .utf8)!)")
                
                guard let httpResponse = response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode) else {
                    print(" RESPONSE 1 error")
                    
                    let decoder = JSONDecoder()
//                    throw try decoder.decode(ErrorResponse.self, from: data)
                    
                    throw APIError.notFound
                }
                return data
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
