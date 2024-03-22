//
//  Config.swift
//  GoCardlessSDK
//
//

import Foundation

public struct Config: Codable {
    public let merchantContactDetails: MerchantContactDetails?
    public let schemeIdentifiers: [SchemeIdentifier]?

    enum CodingKeys: String, CodingKey {
        case merchantContactDetails = "merchant_contact_details"
        case schemeIdentifiers = "scheme_identifiers"
    }

    public init(merchantContactDetails: MerchantContactDetails?, schemeIdentifiers: [SchemeIdentifier]?) {
        self.merchantContactDetails = merchantContactDetails
        self.schemeIdentifiers = schemeIdentifiers
    }
}
