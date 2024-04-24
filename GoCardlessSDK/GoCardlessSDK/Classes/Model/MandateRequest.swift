//
//  MandateRequest.swift
//  GoCardlessSDK
//
//

public struct MandateRequest: Codable {
    public let currency: String?
    public let constraints: MandateConstraints?
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

    public init(currency: String? = nil,
                constraints: MandateConstraints? = nil,
                scheme: String? = nil,
                sweeping: Bool? = nil,
                verify: String? = nil,
                links: Links? = nil,
                metadata: Metadata? = nil,
                description: String? = nil,
                payerRequestedDualSignature: Bool? = nil) {
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
