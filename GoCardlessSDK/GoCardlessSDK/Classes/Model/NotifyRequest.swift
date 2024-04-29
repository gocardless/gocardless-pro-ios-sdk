//
//  NotifyRequest.swift
//  GoCardlessSDK
//
//  Created by Olga Dominguez Gil on 29/04/2024.
//

import Foundation

public struct NotifyRequest: Codable {
    public let notificationType: NotificationType?
    public let redirectUri: String?

    enum CodingKeys: String, CodingKey {
        case notificationType = "notification_type"
        case redirectUri = "redirect_uri"
    }

    public init(notificationType: NotificationType? = nil, redirectUri: String? = nil) {
        self.notificationType = notificationType
        self.redirectUri = redirectUri
    }
}

public enum NotificationType: String, Codable {
    case email = "email"
}
