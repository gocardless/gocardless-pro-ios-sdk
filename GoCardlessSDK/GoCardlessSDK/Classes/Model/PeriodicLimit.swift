//
//  PeriodicLimit.swift
//  GoCardlessSDK
//
//  Created by Olga Dominguez Gil on 19/04/2024.
//

public struct PeriodicLimit: Codable {
    public let period: Period?
    public let maxTotalAmount: Int?
    public let maxPayments: Int?
    public let alignment: Alignment?
    
    enum CodingKeys: String, CodingKey {
        case period = "period"
        case maxTotalAmount = "max_total_amount"
        case maxPayments = "max_payments"
        case alignment = "alignment"
    }
    
    public init(
        period: Period? = nil,
        maxTotalAmount: Int? = nil,
        maxPayments: Int? = nil,
        alignment: Alignment? = nil
    ) {
        self.period = period
        self.maxTotalAmount = maxTotalAmount
        self.maxPayments = maxPayments
        self.alignment = alignment
    }
}

public enum Period: String, Codable {
    case day = "day"
    case week = "week"
    case month = "month"
    case year = "year"
    case flexible = "flexible"
}

public enum Alignment: String, Codable {
    case calendar = "calendar"
    case creation_date = "creation_date"
}
