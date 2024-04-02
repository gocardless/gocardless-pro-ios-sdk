//
//  ConfirmPayerDetailsRequest.swift
//  GoCardlessSDK
//
//  Created by Gunhan Sancar on 15/03/2024.
//

import Foundation

public struct ConfirmPayerDetailsRequest: Codable {
    public let metadata: Metadata?
    public let payerRequestedDualSignature: Bool?

    enum CodingKeys: String, CodingKey {
        case metadata = "metadata"
        case payerRequestedDualSignature = "payer_requested_dual_signature"
    }

    init(metadata: Metadata? = nil, payerRequestedDualSignature: Bool? = nil) {
        self.metadata = metadata
        self.payerRequestedDualSignature = payerRequestedDualSignature
    }
}
