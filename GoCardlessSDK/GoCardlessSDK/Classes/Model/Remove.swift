//
//  Remove.swift
//  GoCardlessSDK
//
//  Created by Gunhan Sancar on 25/01/2024.
//

import Foundation

// MARK: - Remove
public struct Remove: Codable {
    public let error: RemoveError

    enum CodingKeys: String, CodingKey {
        case error = "error"
    }

    public init(error: RemoveError) {
        self.error = error
    }
}

// MARK: - RemoveError
public struct RemoveError: Codable {
    public let documentationURL: String
    public let message: String
    public let type: String
    public let errors: [ErrorElement]
    public let code: Int
    public let requestID: String

    enum CodingKeys: String, CodingKey {
        case documentationURL = "documentation_url"
        case message = "message"
        case type = "type"
        case errors = "errors"
        case code = "code"
        case requestID = "request_id"
    }

    public init(documentationURL: String, message: String, type: String, errors: [ErrorElement], code: Int, requestID: String) {
        self.documentationURL = documentationURL
        self.message = message
        self.type = type
        self.errors = errors
        self.code = code
        self.requestID = requestID
    }
}

// MARK: - ErrorElement
public struct ErrorElement: Codable {
    public let reason: String
    public let message: String

    enum CodingKeys: String, CodingKey {
        case reason = "reason"
        case message = "message"
    }

    public init(reason: String, message: String) {
        self.reason = reason
        self.message = message
    }
}
