//
//  MandateRequest.swift
//  GoCardlessSDK
//
//

public struct MandateRequest: Codable {
    public let currency: String?
    public let constraints: String?
    public let scheme: String?
    public let sweeping: Bool?
    public let verify: String?
    public let links: Links?
    public let metadata: Metadata?
    public let description: String?
    public let payerRequestedDualSignature: Bool?

    enum CodingKeys: String, CodingKey {
        case currency = "currency"
        case constraints = "constraints"
        case scheme = "scheme"
        case sweeping = "sweeping"
        case verify = "verify"
        case links = "links"
        case metadata = "metadata"
        case description = "description"
        case payerRequestedDualSignature = "payer_requested_dual_signature"
    }

    public init(currency: String?, 
                constraints: String?,
                scheme: String?,
                sweeping: Bool?,
                verify: String?,
                links: Links?,
                metadata: Metadata?,
                description: String?,
                payerRequestedDualSignature: Bool?) {
        self.currency = currency
        self.constraints = constraints
        self.scheme = scheme
        self.sweeping = sweeping
        self.verify = verify
        self.links = links
        self.metadata = metadata
        self.description = description
        self.payerRequestedDualSignature = payerRequestedDualSignature
    }
}
