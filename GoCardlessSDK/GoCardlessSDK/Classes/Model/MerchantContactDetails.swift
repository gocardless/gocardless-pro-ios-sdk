//
//  MerchantContactDetails.swift
//  GoCardlessSDK
//
//

import Foundation

public struct MerchantContactDetails: Codable {
    public let email: String?
    public let phoneNumber: String?
    public let name: String?

    enum CodingKeys: String, CodingKey {
        case email = "email"
        case phoneNumber = "phone_number"
        case name = "name"
    }

    public init(email: String?, phoneNumber: String?, name: String?) {
        self.email = email
        self.phoneNumber = phoneNumber
        self.name = name
    }
}
