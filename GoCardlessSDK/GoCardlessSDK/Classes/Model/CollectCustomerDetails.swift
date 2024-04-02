//
//  CollectCustomerDetails.swift
//  GoCardlessSDK
//
//

public struct CollectCustomerDetails: Codable {
    public let incompleteFields: CustomerDetailsIncompleteFields?
    public let defaultCountryCode: String?

    enum CodingKeys: String, CodingKey {
        case incompleteFields = "incomplete_fields"
        case defaultCountryCode = "default_country_code"
    }

    public init(incompleteFields: CustomerDetailsIncompleteFields?,
                defaultCountryCode: String?) {
        self.incompleteFields = incompleteFields
        self.defaultCountryCode = defaultCountryCode
    }
}

public struct CustomerDetailsIncompleteFields: Codable {
    public let customer: [String]?
    public let customerBillingDetail: [String]?

    enum CodingKeys: String, CodingKey {
        case customer = "customer"
        case customerBillingDetail = "customer_billing_detail"
    }

    public init(customer: [String]?, customerBillingDetail: [String]?) {
        self.customer = customer
        self.customerBillingDetail = customerBillingDetail
    }
}
