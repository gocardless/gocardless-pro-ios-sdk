//
//  APIError.swift
//  GoCardlessSDK
//
//  Created by Gunhan Sancar on 25/01/2024.
//

enum APIError: Error {
    case notFound
    case authenticationError
    case permissionError
    case rateLimitError
    case goCardlessInternalError
    case invalidApiUsageError
    case invalidStateError
    case validationFailedError
}
