//
//  BillingRequestFlow.swift
//  GoCardlessSDK
//
//

import Foundation

public struct BillingRequestFlow: Codable {
    public let id: String?
    public let autoFulfil: Bool?
    public let redirectURI: String?
    public let exitURI: String?
    public let authorisationURL: String?
    public let lockCustomerDetails: Bool?
    public let lockBankAccount: Bool?
    public let sessionToken: String?
    public let expiresAt: String?
    public let createdAt: String?
    public let links: Links?
    public let config: Config?
    public let redirectFlowID: String?
    public let showRedirectButtons: Bool?
    public let lockCurrency: Bool?
    public let prefilledCustomer: Customer?
    public let prefilledBankAccount: CollectBankAccount?
    public let language: String?
    public let showSuccessRedirectButton: Bool?
    public let customerDetailsCaptured: Bool?
    public let redirectOrigin: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case autoFulfil = "auto_fulfil"
        case redirectURI = "redirect_uri"
        case exitURI = "exit_uri"
        case authorisationURL = "authorisation_url"
        case lockCustomerDetails = "lock_customer_details"
        case lockBankAccount = "lock_bank_account"
        case sessionToken = "session_token"
        case expiresAt = "expires_at"
        case createdAt = "created_at"
        case links = "links"
        case config = "config"
        case redirectFlowID = "redirect_flow_id"
        case showRedirectButtons = "show_redirect_buttons"
        case lockCurrency = "lock_currency"
        case prefilledCustomer = "prefilled_customer"
        case prefilledBankAccount = "prefilled_bank_account"
        case language = "language"
        case showSuccessRedirectButton = "show_success_redirect_button"
        case customerDetailsCaptured = "customer_details_captured"
        case redirectOrigin = "redirect_origin"
    }

    public init(id: String? = nil,
                autoFulfil: Bool? = nil,
                redirectURI: String? = nil,
                exitURI: String? = nil,
                authorisationURL: String? = nil,
                lockCustomerDetails: Bool? = nil,
                lockBankAccount: Bool? = nil,
                sessionToken: String? = nil,
                expiresAt: String? = nil,
                createdAt: String? = nil,
                links: Links? = nil,
                config: Config? = nil,
                redirectFlowID: String? = nil,
                showRedirectButtons: Bool? = nil,
                lockCurrency: Bool? = nil,
                prefilledCustomer: Customer? = nil,
                prefilledBankAccount: CollectBankAccount? = nil,
                language: String? = nil,
                showSuccessRedirectButton: Bool? = nil,
                customerDetailsCaptured: Bool? = nil,
                redirectOrigin: String? = nil) {
        self.id = id
        self.autoFulfil = autoFulfil
        self.redirectURI = redirectURI
        self.exitURI = exitURI
        self.authorisationURL = authorisationURL
        self.lockCustomerDetails = lockCustomerDetails
        self.lockBankAccount = lockBankAccount
        self.sessionToken = sessionToken
        self.expiresAt = expiresAt
        self.createdAt = createdAt
        self.links = links
        self.config = config
        self.redirectFlowID = redirectFlowID
        self.showRedirectButtons = showRedirectButtons
        self.lockCurrency = lockCurrency
        self.prefilledCustomer = prefilledCustomer
        self.prefilledBankAccount = prefilledBankAccount
        self.language = language
        self.showSuccessRedirectButton = showSuccessRedirectButton
        self.customerDetailsCaptured = customerDetailsCaptured
        self.redirectOrigin = redirectOrigin
    }
}
