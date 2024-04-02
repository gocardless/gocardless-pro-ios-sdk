//
//  Payment.swift
//  GoCardlessSDK
//
//  Created by Gunhan Sancar on 01/04/2024.
//

import Foundation

/// Payment objects represent payments from a customer to a creditor
public struct Payment: Codable {
    /// Unique identifier, beginning with “PM”.
    public let id: String?
    /// Amount, in the lowest denomination for the currency (e.g. pence in GBP, cents in EUR).
    public let amount: Int?
    /// Amount refunded, in the lowest denomination for the currency (e.g. pence in GBP, cents in EUR).
    public let amountRefunded: Int?
    /**
     A future date on which the payment should be collected.
     If not specified, the payment will be collected as soon as possible.
     If the value is before the mandate’s next_possible_charge_date creation will fail.
     If the value is not a working day it will be rolled forwards to the next available one.
     */
    public let chargeDate: String?
    /// Fixed timestamp, recording when this resource was created.
    public let createdAt: String?
    /// ISO 4217 currency code. Currently “AUD”, “CAD”, “DKK”, “EUR”, “GBP”, “NZD”, “SEK” and “USD” are supported.
    public let currency: String?
    /// A human-readable description of the payment.
    public let description: String?
    /// This field indicates whether the ACH payment is processed through Faster ACH or standard ACH.
    public let fasterAch: Bool?
    /// Key-value store of custom data. Up to 3 keys are permitted, with key names up to 50 characters and values up to 500 characters.
    public let metadata: Metadata?
    /// An optional reference that will appear on your customer’s bank statement. The character limit for this reference is dependent on the scheme.
    public let reference: String?
    /// On failure, automatically retry the payment using intelligent retries. Default is false.
    public let retryIfPossible: Bool?
    /// Payment status
    public let status: PaymentStatus?
    /// Payment links
    public let links: PaymentLinks?
    /// Payment FX
    public let fx: PaymentFx?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case amount = "amount"
        case amountRefunded = "amount_refunded"
        case chargeDate = "charge_date"
        case createdAt = "created_at"
        case currency = "currency"
        case description = "description"
        case fasterAch = "faster_ach"
        case metadata = "metadata"
        case reference = "reference"
        case retryIfPossible = "retry_if_possible"
        case status = "status"
        case links = "links"
        case fx = "fx"
    }
    
    init(id: String? = nil,
         amount: Int? = nil,
         amountRefunded: Int? = nil,
         chargeDate: String? = nil,
         createdAt: String? = nil,
         currency: String? = nil,
         description: String? = nil,
         fasterAch: Bool? = nil,
         metadata: Metadata? = nil,
         reference: String? = nil,
         retryIfPossible: Bool? = nil,
         status: PaymentStatus? = nil,
         links: PaymentLinks? = nil,
         fx: PaymentFx? = nil) {
        self.id = id
        self.amount = amount
        self.amountRefunded = amountRefunded
        self.chargeDate = chargeDate
        self.createdAt = createdAt
        self.currency = currency
        self.description = description
        self.fasterAch = fasterAch
        self.metadata = metadata
        self.reference = reference
        self.retryIfPossible = retryIfPossible
        self.status = status
        self.links = links
        self.fx = fx
    }
}

/// Foreign Exchange
public struct PaymentFx: Codable {
    /// Estimated rate that will be used in the foreign exchange of the amount into the fx_currency.
    public let estimatedExchangeRate: String?
    /// Rate used in the foreign exchange of the amount into the fx_currency.
    public let exchangeRate: String?
    /// Amount that was paid out in the fx_currency after foreign exchange. Present only after the resource has been paid out.
    public let fxAmount: Int?
    /// ISO 4217 code for the currency in which amounts will be paid out (after foreign exchange).
    public let fxCurrency: String?
    
    enum CodingKeys: String, CodingKey {
        case estimatedExchangeRate = "estimated_exchange_rate"
        case exchangeRate = "exchange_rate"
        case fxAmount = "fx_amount"
        case fxCurrency = "fx_currency"
    }
    
    init(estimatedExchangeRate: String? = nil,
         exchangeRate: String? = nil,
         fxAmount: Int? = nil,
         fxCurrency: String? = nil) {
        self.estimatedExchangeRate = estimatedExchangeRate
        self.exchangeRate = exchangeRate
        self.fxAmount = fxAmount
        self.fxCurrency = fxCurrency
    }
}

/// Represents the status of a payment
public enum PaymentStatus: String, Codable {
    case pendingCustomerApproval = "pending_customer_approval"
    case pendingSubmission = "pending_submission"
    case submitted = "submitted"
    case confirmed = "confirmed"
    case paidOut = "paid_out"
    case cancelled = "cancelled"
    case customerApprovalDenied = "customer_approval_denied"
    case failed = "failed"
    case chargedBack = "charged_back"
}

/// Links of a payment object
public struct PaymentLinks: Codable {
    /// ID of creditor to which the collected payment will be sent.
    public let creditor: String?
    /// ID of instalment_schedule from which this payment was created.
    public let instalmentSchedule: String?
    /// ID of the mandate against which this payment should be collected.
    public let mandate: String?
    /// ID of payout which contains the funds from this payment.
    public let payout: String?
    /// ID of subscription from which this payment was created.
    public let subscription: String?
    
    enum CodingKeys: String, CodingKey {
        case creditor = "creditor"
        case instalmentSchedule = "instalment_schedule"
        case mandate = "mandate"
        case payout = "payout"
        case subscription = "subscription"
    }
    
    init(creditor: String? = nil,
         instalmentSchedule: String? = nil,
         mandate: String? = nil,
         payout: String? = nil,
         subscription: String? = nil) {
        self.creditor = creditor
        self.instalmentSchedule = instalmentSchedule
        self.mandate = mandate
        self.payout = payout
        self.subscription = subscription
    }
}
