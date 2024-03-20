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
        var request = URLRequest(environemnt: envrionment, endpoint: endpoint)
            .setHeaders(provider: httpHeaderProvider)
        
        if let body = endpoint.body {
            let encoded = try? JSONEncoder().encode(body)
            request.httpBody = encoded
        }
        
        print(" HttpClient.request.path: \(endpoint.path)")
        
        return urlSession.dataTaskPublisher(for: request)
            .tryMap { data, response in
                print(" RESPONSE tryMap:")
//                print(" RESPONSE.data: \n\(String(data: data, encoding: .utf8)!)")
                
                let httpResponse = response as? HTTPURLResponse
                let code = httpResponse?.statusCode ?? -999
                print(" [ -> ] HTTPClient.response.code: \(code)")
                
                guard (200...299).contains(code) else {
                    switch code {
                    case 401: throw APIError.authenticationError
                    case 403: throw APIError.permissionError
                    case 429: throw APIError.rateLimitError
                    default: break
                    }
                    
                    let decoder = JSONDecoder()
                    let errorBody = try decoder.decode(ErrorWrapper.self, from: data)
                    
                    guard let errorType = errorBody.errorDetail?.type else {
                        throw APIError.goCardlessInternalError
                    }
                    
                    switch errorType {
                    case ErrorType.gocardless: throw APIError.goCardlessInternalError
                    case ErrorType.invalidAPIUsage: throw APIError.invalidApiUsageError
                    case ErrorType.invalidState: throw APIError.invalidStateError
                    case ErrorType.validationFailed: throw APIError.validationFailedError
                    }
                }
                return data
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
