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
            case 401: throw APIError.init(type: APIErrorType.authenticationError)
            case 403: throw APIError.init(type: APIErrorType.permissionError)
            case 429: throw APIError.init(type: APIErrorType.rateLimitError)
            default: break
            }
            
            var errorBody: ErrorWrapper? = nil
            
            do {
                let decoder = JSONDecoder()
                errorBody = try decoder.decode(ErrorWrapper.self, from: data)
            } catch {
                throw APIError.init(type: APIErrorType.malformedResponseError)
            }
            
            guard let errorType = errorBody?.errorDetail?.type else {
                throw APIError.init(type: APIErrorType.goCardlessInternalError)
            }
            
            switch errorType {
            case ErrorType.gocardless: 
                throw APIError.init(
                    type: APIErrorType.goCardlessInternalError,
                    errorDetail: errorBody?.errorDetail
                )
            case ErrorType.invalidAPIUsage: 
                throw APIError.init(
                type: APIErrorType.invalidApiUsageError,
                errorDetail: errorBody?.errorDetail
            )
            case ErrorType.invalidState: throw APIError.init(
                type: APIErrorType.invalidStateError,
                errorDetail: errorBody?.errorDetail
            )
            case ErrorType.validationFailed: throw APIError.init(
                type: APIErrorType.validationFailedError,
                errorDetail: errorBody?.errorDetail
            ) 
            }
        }
    }
}
