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
    public let id: String?
    public let authorisationType: String?
    public let authorisedAt: String?
    public let createdAt: String?
    public let expiresAt: String?
    public let lastVisitedAt: String?
    public let links: Links?
    public let qrCodeUrl: String?
    public let redirectUri: String?
    public let url: String?
    public let adapter: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case authorisationType = "authorisation_type"
        case authorisedAt = "authorised_at"
        case createdAt = "created_at"
        case expiresAt = "expires_at"
        case lastVisitedAt = "last_visited_at"
        case links = "links"
        case qrCodeUrl = "qr_code_url"
        case redirectUri = "redirect_uri"
        case url = "url"
        case adapter = "adapter"
    }

    public init(
        id: String? = nil,
        authorisationType: String? = nil,
        authorisedAt: String? = nil,
        createdAt: String? = nil,
        expiresAt: String? = nil,
        lastVisitedAt: String? = nil,
        links: Links? = nil,
        qrCodeUrl: String? = nil,
        redirectUri: String? = nil,
        url: String? = nil,
        adapter: String? = nil) {
            self.id = id
            self.authorisationType = authorisationType
            self.authorisedAt = authorisedAt
            self.createdAt = createdAt
            self.expiresAt = expiresAt
            self.lastVisitedAt = lastVisitedAt
            self.links = links
            self.qrCodeUrl = qrCodeUrl
            self.redirectUri = redirectUri
            self.url = url
            self.adapter = adapter
    }
}
