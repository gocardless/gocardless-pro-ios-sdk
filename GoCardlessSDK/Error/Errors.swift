//
//  Errors.swift
//  GoCardlessSDK
//
//

import Foundation

public struct ErrorWrapper: Codable {
    public let errorDetail: ErrorDetail?

    enum CodingKeys: String, CodingKey {
        case errorDetail = "error"
    }

    public init(error: ErrorDetail? = nil) {
        self.errorDetail = error
    }
}

public enum ErrorType: String, Codable {
    case gocardless = "gocardless"
    case invalidAPIUsage = "invalid_api_usage"
    case invalidState = "invalid_state"
    case validationFailed = "validation_failed"
}

public struct ErrorDetail: Codable {
    public let message: String?
    public let errors: [ErrorReason]?
    public let documentationUrl: String?
    public let type: ErrorType?
    public let requestId: String?
    public let code: Int?

    enum CodingKeys: String, CodingKey {
        case message = "message"
        case errors = "errors"
        case documentationUrl = "documentation_url"
        case type = "type"
        case requestId = "request_id"
        case code = "code"
    }

    init(message: String? = nil,
         errors: [ErrorReason]? = nil,
         documentationUrl: String? = nil,
         type: ErrorType? = nil,
         requestId: String? = nil,
         code: Int? = nil) {
        self.message = message
        self.errors = errors
        self.documentationUrl = documentationUrl
        self.type = type
        self.requestId = requestId
        self.code = code
    }
}

public struct ErrorReason: Codable {
    public let reason: String?
    public let message: String?
    
    enum CodingKeys: String, CodingKey {
        case reason = "reason"
        case message = "message"
    }
    
    init(reason: String? = nil, message: String? = nil) {
        self.reason = reason
        self.message = message
    }
}

