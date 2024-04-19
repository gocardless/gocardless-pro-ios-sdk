//
//  MandateConstraints.swift
//  GoCardlessSDK
//
//  Created by Olga Dominguez Gil on 19/04/2024.
//

public struct MandateConstraints: Codable {
    let periodicLimits: [PeriodicLimit]?
    let startDate: String?
    let endDate: String?
    let maxAmountPerPayment: Int?
    
    enum CodingKeys: String, CodingKey {
        case periodicLimits = "periodic_limits"
        case startDate = "start_date"
        case endDate = "end_date"
        case maxAmountPerPayment = "max_amount_per_payment"
    }
    
    public init(
        periodicLimits: [PeriodicLimit]? = nil,
        startDate: String? = nil,
        endDate: String? = nil,
        maxAmountPerPayment: Int? = nil) {
        self.periodicLimits = periodicLimits
        self.startDate = startDate
        self.endDate = endDate
        self.maxAmountPerPayment = maxAmountPerPayment
    }
}
