//
//  BillingRequestWrapper.swift
//  GoCardlessSDK
//
//

public struct BillingRequestWrapper: Codable {
    public let billingRequests: BillingRequest?

    enum CodingKeys: String, CodingKey {
        case billingRequests = "billing_requests"
    }

    public init(billingRequests: BillingRequest?) {
        self.billingRequests = billingRequests
    }
}
