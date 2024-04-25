//
//  BankAuthorisationWrapper.swift
//  GoCardlessSDK
//


public struct BankAuthorisationWrapper: Codable {
    public let bankAuthorisations: BankAuthorisation?

    enum CodingKeys: String, CodingKey {
        case bankAuthorisations = "bank_authorisations"
    }

    public init(bankAuthorisations: BankAuthorisation?) {
        self.bankAuthorisations = bankAuthorisations
    }
}
