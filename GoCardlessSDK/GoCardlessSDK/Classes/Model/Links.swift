//
//  Links.swift
//  GoCardlessSDK
//
//

public struct Links: Codable {
    public let customer: String?
    public let customerBillingDetail: String?
    public let creditor: String?
    public let organisation: String?
    public let paymentRequest: String?
    public let mandateRequest: String?
    public let billingRequest: String?

    enum CodingKeys: String, CodingKey {
        case customer = "customer"
        case customerBillingDetail = "customer_billing_detail"
        case creditor = "creditor"
        case organisation = "organisation"
        case paymentRequest = "payment_request"
        case mandateRequest = "mandate_request"
        case billingRequest = "billing_request"
    }

    public init(customer: String?, 
                customerBillingDetail: String?,
                creditor: String?,
                organisation: String?,
                paymentRequest: String?,
                mandateRequest: String?,
                billingRequest: String?) {
        self.customer = customer
        self.customerBillingDetail = customerBillingDetail
        self.creditor = creditor
        self.organisation = organisation
        self.paymentRequest = paymentRequest
        self.mandateRequest = mandateRequest
        self.billingRequest = billingRequest
    }
}
