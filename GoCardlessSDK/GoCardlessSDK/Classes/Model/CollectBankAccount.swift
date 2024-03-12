//
//  CollectBankAccount.swift
//  GoCardlessSDK
//
//

import Foundation

public struct CollectBankAccount: Codable {
    public let accountHolderName: String?
    public let accountNumber: String?
    public let accountNumberSuffix: String?
    public let accountType: String?
    public let bankCode: String?
    public let branchCode: String?
    public let countryCode: String?
    public let currency: String?
    public let iban: String?
    public let metadata: Metadata?
    public let payId: String?

    enum CodingKeys: String, CodingKey {
        case accountHolderName = "account_holder_name"
        case accountNumber = "account_number"
        case accountNumberSuffix = "account_number_suffix"
        case accountType = "account_type"
        case bankCode = "bank_code"
        case branchCode = "branch_code"
        case countryCode = "country_code"
        case currency = "currency"
        case iban = "iban"
        case metadata = "metadata"
        case payId = "pay_id"
    }
    
    init(accountHolderName: String?, accountNumber: String?, accountNumberSuffix: String?, accountType: String?, bankCode: String?, branchCode: String?, countryCode: String?, currency: String?, iban: String?, metadata: Metadata?, payId: String?) {
        self.accountHolderName = accountHolderName
        self.accountNumber = accountNumber
        self.accountNumberSuffix = accountNumberSuffix
        self.accountType = accountType
        self.bankCode = bankCode
        self.branchCode = branchCode
        self.countryCode = countryCode
        self.currency = currency
        self.iban = iban
        self.metadata = metadata
        self.payId = payId
    }
}

