//
//  BillingRequestFlowWrapper.swift
//  GoCardlessSDK
//
//

public struct BillingRequestFlowWrapper: Codable {
    public let billingRequestFlows: BillingRequestFlow?

    enum CodingKeys: String, CodingKey {
        case billingRequestFlows = "billing_request_flows"
    }

    public init(billingRequestFlows: BillingRequestFlow?) {
        self.billingRequestFlows = billingRequestFlows
    }
}
