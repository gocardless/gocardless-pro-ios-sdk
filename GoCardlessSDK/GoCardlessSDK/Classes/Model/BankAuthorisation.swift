//
//  BankAuthorisation.swift
//  GoCardlessSDK
//
//

/**
 * Represents a bank authorisation resource returned from the API.
 *
 * Bank Authorisations can be used to authorise Billing Requests. Authorisations are created against
 * a specific bank, usually the bank that provides the payer's account.
 *
 * Creation of Bank Authorisations is only permitted from GoCardless hosted UIs (see Billing Request
 * Flows) to ensure we meet regulatory requirements for checkout flows.
 */
public struct BankAuthorisation: Codable {
    /// Type of authorisation, can be either 'mandate' or 'payment'.
    public let authorisationType: String?
    public let adapter: String?

    enum CodingKeys: String, CodingKey {
        case authorisationType = "authorisation_type"
        case adapter = "adapter"
    }

    public init(authorisationType: String?, adapter: String?) {
        self.authorisationType = authorisationType
        self.adapter = adapter
    }
}
