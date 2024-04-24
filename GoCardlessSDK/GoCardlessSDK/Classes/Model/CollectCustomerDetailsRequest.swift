//
//  CollectCustomerDetailsRequest.swift
//  GoCardlessSDK
//
//

public struct CollectCustomerDetailsRequest: Codable {
    public let customer: Customer?
    public let customerBillingDetail: CustomerBillingDetail?

    enum CodingKeys: String, CodingKey {
        case customer = "customer"
        case customerBillingDetail = "customer_billing_detail"
    }

    public init(customer: Customer? = nil, customerBillingDetail: CustomerBillingDetail? = nil) {
        self.customer = customer
        self.customerBillingDetail = customerBillingDetail
    }
}
