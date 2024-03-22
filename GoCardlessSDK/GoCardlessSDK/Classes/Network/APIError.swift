//
//  APIError.swift
//  GoCardlessSDK
//
//  Created by Gunhan Sancar on 25/01/2024.
//


/// Represents different API errors that can occur during network requests.
enum APIError: Error {
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
}
