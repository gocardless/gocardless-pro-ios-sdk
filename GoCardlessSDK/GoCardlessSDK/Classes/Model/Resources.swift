//
//  Resources.swift
//  GoCardlessSDK
//
//

public struct Resources: Codable {
    public let customer: Customer?
    public let customerBillingDetail: CustomerBillingDetail?

    enum CodingKeys: String, CodingKey {
        case customer = "customer"
        case customerBillingDetail = "customer_billing_detail"
    }

    public init(customer: Customer?, customerBillingDetail: CustomerBillingDetail?) {
        self.customer = customer
        self.customerBillingDetail = customerBillingDetail
    }
}
