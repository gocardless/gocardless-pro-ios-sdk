//
//  CollectCustomerDetailsRequest.swift
//  GoCardlessSDK
//
//

public struct CollectCustomerDetailsRequest: Codable {
    public let customer: Customer?
    public let customerBillingDetail: String?

    enum CodingKeys: String, CodingKey {
        case customer = "customer"
        case customerBillingDetail = "customer_billing_detail"
    }

    init(customer: Customer? = nil, customerBillingDetail: String? = nil) {
        self.customer = customer
        self.customerBillingDetail = customerBillingDetail
    }
}
