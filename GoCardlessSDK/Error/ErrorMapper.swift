//
//  ErrorMapper.swift
//  GoCardlessSDK
//
//  Created by Gunhan Sancar on 02/04/2024.
//

import Foundation

/**
 * Map the received errors to the correct `Error` objects
 */
class ErrorMapper {
    
    /// Processes the error code and data to a `GoCardlessError`
    func process(code: Int, data: Data) throws {
        guard (200...299).contains(code) else {
            switch code {
            case 401: throw APIError.authenticationError
            case 403: throw APIError.permissionError
            case 429: throw APIError.rateLimitError
            default: break
            }
            
            do {
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
            } catch {
                throw APIError.malformedResponseError
            }
        }
    }
}
