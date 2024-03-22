//
//  Action.swift
//  GoCardlessSDK
//
//

/**
 List of actions that can be performed before this billing request can be fulfilled.
 */
public struct Action: Codable {
    /// Unique identifier for the action.
    public let type: ActionType?
    /// Informs you whether the action is required to fulfil the billing request or not.
    public let actionRequired: Bool?
    /// Which other action types this action can complete.
    public let completesActions: [String]?
    /// Requires completing these actions before this action can be completed.
    public let requiresActions: [String]?
    /// Status of the action
    public let status: ActionStatus?
    /// List of currencies the current mandate supports
    public let availableCurrencies: [String]?
    /// Additional parameters to help complete the collect_customer_details action
    public let collectCustomerDetails: CollectCustomerDetails?
    public let institutionGuessStatus: String?
    public let availableCountryCodes: [String]?
    /// Describes the behaviour of bank authorisations, for the bank_authorisation action
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
    
    public init(type: ActionType?,
                actionRequired: Bool?,
                completesActions: [String]?,
                requiresActions: [String]?,
                status: ActionStatus?,
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

public enum ActionType: String, Codable {
    case chooseCurrency = "choose_currency"
    case collectAmount = "collect_amount"
    case collectCustomerDetails = "collect_customer_details"
    case collectBankAccount = "collect_bank_account"
    case bankAuthorisation = "bank_authorisation"
    case confirmPayerDetails = "confirm_payer_details"
    case selectInstitution = "select_institution"
    case unknown = "unknown"
}

/// Represents the status for an action
public enum ActionStatus: String, Codable {
    case pending = "pending"
    case completed = "completed"
}
