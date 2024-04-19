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
    private let errorMapper: ErrorMapper
    
    init(httpHeaderProvider: HttpHeaderProvider,
         envrionment: Environment,
         urlSession: URLSession = URLSession.shared,
         errorMapper: ErrorMapper) {
        self.httpHeaderProvider = httpHeaderProvider
        self.envrionment = envrionment
        self.urlSession = urlSession
        self.errorMapper = errorMapper
    }
    
    func request(endpoint: Endpoint) -> AnyPublisher<Data, Error> {
        var request = URLRequest(environemnt: envrionment, endpoint: endpoint)
            .setHeaders(provider: httpHeaderProvider)
        
        if let body = endpoint.body {
            let encoded = try? JSONEncoder().encode(body)
            request.httpBody = encoded
        }
        print(request)
        
        return urlSession.dataTaskPublisher(for: request)
            .tryMap { [weak self] data, response in
                let httpResponse = response as? HTTPURLResponse
                let code = httpResponse?.statusCode ?? -999
                try self?.errorMapper.process(code: code, data: data)
                print(data)
                return data
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
