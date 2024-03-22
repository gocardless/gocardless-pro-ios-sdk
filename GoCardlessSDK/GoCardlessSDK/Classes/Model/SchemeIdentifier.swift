//
//  SchemeIdentifier.swift
//  GoCardlessSDK
//
//

import Foundation

public struct SchemeIdentifier: Codable {
    public let scheme: String?
    public let advanceNotice: Int?
    public let name: String?
    public let reference: String?
    public let address: String?
    public let bankStatementName: String?
    public let registeredName: String?

    enum CodingKeys: String, CodingKey {
        case scheme = "scheme"
        case advanceNotice = "advance_notice"
        case name = "name"
        case reference = "reference"
        case address = "address"
        case bankStatementName = "bank_statement_name"
        case registeredName = "registered_name"
    }

    public init(scheme: String?, advanceNotice: Int?, name: String?, reference: String?, address: String?, bankStatementName: String?, registeredName: String?) {
        self.scheme = scheme
        self.advanceNotice = advanceNotice
        self.name = name
        self.reference = reference
        self.address = address
        self.bankStatementName = bankStatementName
        self.registeredName = registeredName
    }
}
