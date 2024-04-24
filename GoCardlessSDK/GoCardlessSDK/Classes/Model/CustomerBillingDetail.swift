//
//  CustomerBillingDetail.swift
//  GoCardlessSDK
//
//

public struct CustomerBillingDetail: Codable {
    public let id: String?
    public let createdAt: String?
    public let addressLine1: String?
    public let addressLine2: String?
    public let addressLine3: String?
    public let city: String?
    public let region: String?
    public let postalCode: String?
    public let countryCode: String?
    public let swedishIdentityNumber: String?
    public let danishIdentityNumber: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case createdAt = "created_at"
        case addressLine1 = "address_line1"
        case addressLine2 = "address_line2"
        case addressLine3 = "address_line3"
        case city = "city"
        case region = "region"
        case postalCode = "postal_code"
        case countryCode = "country_code"
        case swedishIdentityNumber = "swedish_identity_number"
        case danishIdentityNumber = "danish_identity_number"
    }

    public init(id: String? = nil,
                createdAt: String? = nil,
                addressLine1: String? = nil,
                addressLine2: String? = nil,
                addressLine3: String? = nil,
                city: String? = nil,
                region: String? = nil,
                postalCode: String? = nil,
                countryCode: String? = nil,
                swedishIdentityNumber: String? = nil,
                danishIdentityNumber: String? = nil) {
        self.id = id
        self.createdAt = createdAt
        self.addressLine1 = addressLine1
        self.addressLine2 = addressLine2
        self.addressLine3 = addressLine3
        self.city = city
        self.region = region
        self.postalCode = postalCode
        self.countryCode = countryCode
        self.swedishIdentityNumber = swedishIdentityNumber
        self.danishIdentityNumber = danishIdentityNumber
    }
}
