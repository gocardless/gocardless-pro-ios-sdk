//
//  PaymentRequest.swift
//  GoCardlessSDK
//
//

public struct PaymentRequest: Codable {
    public let description: String?
    public let currency: String?
    public let amount: Int?
    public let minAmount: String?
    public let maxAmount: String?
    public let defaultMinAmount: String?
    public let defaultMaxAmount: String?
    public let appFee: String?
    public let scheme: String?
    public let links: Links?
    public let metadata: Metadata?
    public let flexibleAmount: Bool?

    enum CodingKeys: String, CodingKey {
        case description = "description"
        case currency = "currency"
        case amount = "amount"
        case minAmount = "min_amount"
        case maxAmount = "max_amount"
        case defaultMinAmount = "default_min_amount"
        case defaultMaxAmount = "default_max_amount"
        case appFee = "app_fee"
        case scheme = "scheme"
        case links = "links"
        case metadata = "metadata"
        case flexibleAmount = "flexible_amount"
    }

    public init(description: String? = nil,
                currency: String? = nil,
                amount: Int? = nil,
                minAmount: String? = nil,
                maxAmount: String? = nil,
                defaultMinAmount: String? = nil,
                defaultMaxAmount: String? = nil,
                appFee: String? = nil,
                scheme: String? = nil,
                links: Links? = nil,
                metadata: Metadata? = nil,
                flexibleAmount: Bool? = nil) {
        self.description = description
        self.currency = currency
        self.amount = amount
        self.minAmount = minAmount
        self.maxAmount = maxAmount
        self.defaultMinAmount = defaultMinAmount
        self.defaultMaxAmount = defaultMaxAmount
        self.appFee = appFee
        self.scheme = scheme
        self.links = links
        self.metadata = metadata
        self.flexibleAmount = flexibleAmount
    }
}
