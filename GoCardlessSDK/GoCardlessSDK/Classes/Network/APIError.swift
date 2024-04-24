//
//  APIError.swift
//  GoCardlessSDK
//
//  Created by Gunhan Sancar on 25/01/2024.
//

import Combine

public struct APIError: Error {
    
    public let type: APIErrorType?
    public let errorDetail: ErrorDetail?
    
    init(type: APIErrorType, errorDetail: ErrorDetail? = nil) {
        self.type = type
        self.errorDetail = errorDetail
    }
}

/// Represents different API errors that can occur during network requests.
public enum APIErrorType {
    /// Represents an error that occurs when user credentials/api key provided is invalid.
    case authenticationError
    /// Represents an error that occurs when user is not permitted to do desired action.
    case permissionError
    /// Represents an error that occurs when number of api requests are exceeded configured rate limit.
    case rateLimitError
    /// Represents an error that occurs when an internal error occurred while processing your request.
    case goCardlessInternalError
    /// Represents an error that occurs when there is an error with the request you made.
    case invalidApiUsageError
    /// Represents an error that occurs when the action you are trying to perform is invalid due to the state of the resource you are requesting it on.
    case invalidStateError
    /// Represents an error that occurs when the parameters submitted with your request were invalid.
    case validationFailedError
    /// Represents an error that occurs when a response is returned from the API which isn't valid JSON (for example, an HTML error page returned from a load balancer)
    case malformedResponseError
}

extension Publisher {
    func mapAPIError() -> Publishers.MapError<Self, APIError> {
        return self.mapError { error in
            if let apiError = error as? APIError {
                return apiError
            } else {
                return APIError.init(type: APIErrorType.malformedResponseError)
            }
        }
    }
}
