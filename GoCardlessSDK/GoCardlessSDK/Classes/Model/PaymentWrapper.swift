//
//  PaymentWrapper.swift
//  GoCardlessSDK
//
//  Created by Gunhan Sancar on 01/04/2024.
//

import Foundation

public struct PaymentWrapper: Codable {
    public let payments: Payment?

    enum CodingKeys: String, CodingKey {
        case payments = "payments"
    }
    
    init(payments: Payment? = nil) {
        self.payments = payments
    }
}
