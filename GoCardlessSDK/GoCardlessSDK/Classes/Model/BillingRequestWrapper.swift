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

public struct BillingRequestList: Codable {
    public let billingRequests: [BillingRequest]?
    public let meta: [BillingRequest]?

    enum CodingKeys: String, CodingKey {
        case billingRequests = "billing_requests"
        case meta = "meta"
    }

    public init(billingRequests: [BillingRequest]? = nil, meta: [BillingRequest]? = nil) {
        self.billingRequests = billingRequests
        self.meta = meta
    }
}
