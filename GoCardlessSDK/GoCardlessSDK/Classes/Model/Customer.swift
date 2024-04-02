//
//  Customer.swift
//  GoCardlessSDK
//
//

public struct Customer: Codable, Identifiable {
    public let id: String?
    public let createdAt: String?
    public let email: String?
    public let givenName: String?
    public let familyName: String?
    public let companyName: String?
    public let addressLine1: String?
    public let addressLine2: String?
    public let addressLine3: String?
    public let city: String?
    public let region: String?
    public let postalCode: String?
    public let countryCode: String?
    public let language: String?
    public let swedishIdentityNumber: String?
    public let danishIdentityNumber: String?
    public let phoneNumber: String?
    public let metadata: Metadata?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case createdAt = "created_at"
        case email = "email"
        case givenName = "given_name"
        case familyName = "family_name"
        case companyName = "company_name"
        case addressLine1 = "address_line1"
        case addressLine2 = "address_line2"
        case addressLine3 = "address_line3"
        case city = "city"
        case region = "region"
        case postalCode = "postal_code"
        case countryCode = "country_code"
        case language = "language"
        case swedishIdentityNumber = "swedish_identity_number"
        case danishIdentityNumber = "danish_identity_number"
        case phoneNumber = "phone_number"
        case metadata = "metadata"
    }
    
    public init(id: String,
                createdAt: String,
                email: String,
                givenName: String,
                familyName: String,
                companyName: String?,
                addressLine1: String,
                addressLine2: String?,
                addressLine3: String?, 
                city: String,
                region: String?,
                postalCode: String,
                countryCode: String,
                language: String,
                swedishIdentityNumber: String?,
                danishIdentityNumber: String?,
                phoneNumber: String?,
                metadata: Metadata?) {
        self.id = id
        self.createdAt = createdAt
        self.email = email
        self.givenName = givenName
        self.familyName = familyName
        self.companyName = companyName
        self.addressLine1 = addressLine1
        self.addressLine2 = addressLine2
        self.addressLine3 = addressLine3
        self.city = city
        self.region = region
        self.postalCode = postalCode
        self.countryCode = countryCode
        self.language = language
        self.swedishIdentityNumber = swedishIdentityNumber
        self.danishIdentityNumber = danishIdentityNumber
        self.phoneNumber = phoneNumber
        self.metadata = metadata
    }
    
    public func fullAddress() -> String {
        [addressLine1, addressLine2, addressLine3, city, region, postalCode, countryCode]
            .compactMap { $0 }
            .joined(separator: "\n")
    }
}

public struct Customers: Codable {
    public let customers: [Customer]
    
    enum CodingKeys: String, CodingKey {
        case customers = "customers"
    }
    
    public init(customers: [Customer]) {
        self.customers = customers
    }
}
