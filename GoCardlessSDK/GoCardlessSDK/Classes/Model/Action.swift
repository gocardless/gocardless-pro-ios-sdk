//
//  Action.swift
//  GoCardlessSDK
//
//

public struct Action: Codable {
    public let type: String?
    public let actionRequired: Bool?
    public let completesActions: [String]?
    public let requiresActions: [String]?
    public let status: String?
    public let availableCurrencies: [String]?
    public let collectCustomerDetails: CollectCustomerDetails?
    public let institutionGuessStatus: String?
    public let availableCountryCodes: [String]?
    public let bankAuthorisation: BankAuthorisation?

    enum CodingKeys: String, CodingKey {
        case type = "type"
        case actionRequired = "required"
        case completesActions = "completes_actions"
        case requiresActions = "requires_actions"
        case status = "status"
        case availableCurrencies = "available_currencies"
        case collectCustomerDetails = "collect_customer_details"
        case institutionGuessStatus = "institution_guess_status"
        case availableCountryCodes = "available_country_codes"
        case bankAuthorisation = "bank_authorisation"
    }

    public init(type: String?, 
                actionRequired: Bool?,
                completesActions: [String]?,
                requiresActions: [String]?,
                status: String?,
                availableCurrencies: [String]?,
                collectCustomerDetails: CollectCustomerDetails?,
                institutionGuessStatus: String?,
                availableCountryCodes: [String]?,
                bankAuthorisation: BankAuthorisation?) {
        self.type = type
        self.actionRequired = actionRequired
        self.completesActions = completesActions
        self.requiresActions = requiresActions
        self.status = status
        self.availableCurrencies = availableCurrencies
        self.collectCustomerDetails = collectCustomerDetails
        self.institutionGuessStatus = institutionGuessStatus
        self.availableCountryCodes = availableCountryCodes
        self.bankAuthorisation = bankAuthorisation
    }
}
