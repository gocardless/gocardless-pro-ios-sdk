//
//  BillingRequest.swift
//  GoCardlessSDK
//
//

public struct BillingRequest: Codable {
    /// Unique identifier, beginning with "BRQ".
    public let id: String?
    /// Fixed [timestamp](#api-usage-time-zones--dates), recording when this resource was created.
    public let createdAt: String?
    /// Represents the status of a billing request
    public let status: BillingRequestStatus?
    /// Request for a mandate
    public let mandateRequest: MandateRequest?
    /// Request for a one-off strongly authorised payment
    public let paymentRequest: PaymentRequest?
    /// Key-value store of custom data. Up to 3 keys are permitted, with key names up to 50 characters and values up to 500 characters.
    public let metadata: Metadata?
    public let links: Links?
    /**
     (Optional) If true, this billing request can fallback from instant payment to direct debit.
     Should not be set if GoCardless payment intelligence feature is used.
     
     See [Billing Requests: Retain customers with
     Fallbacks](https://developer.gocardless.com/billing-requests/retain-customers-with-fallbacks/)
     for more information.
     */
    public let fallbackEnabled: Bool?
    /// Once the fallback occurs, then the fallback_occurred the parameter will be set to `true`
    public let fallbackOccurred: Bool?
    public let signFlowURL: String?
    public let creditorName: String?
    /// List of actions that can be performed before this billing request can be fulfilled.
    public let actions: [Action]?
    public let resources: Resources?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case createdAt = "created_at"
        case status = "status"
        case mandateRequest = "mandate_request"
        case paymentRequest = "payment_request"
        case metadata = "metadata"
        case links = "links"
        case fallbackEnabled = "fallback_enabled"
        case fallbackOccurred = "fallback_occurred"
        case signFlowURL = "sign_flow_url"
        case creditorName = "creditor_name"
        case actions = "actions"
        case resources = "resources"
    }
    
    public init(id: String? = nil,
                createdAt: String? = nil,
                status: BillingRequestStatus? = nil,
                mandateRequest: MandateRequest? = nil,
                paymentRequest: PaymentRequest? = nil,
                metadata: Metadata? = nil,
                links: Links? = nil,
                fallbackEnabled: Bool? = nil,
                fallbackOccurred: Bool? = nil,
                signFlowURL: String? = nil,
                creditorName: String? = nil,
                actions: [Action]? = nil,
                resources: Resources? = nil) {
        self.id = id
        self.createdAt = createdAt
        self.status = status
        self.mandateRequest = mandateRequest
        self.paymentRequest = paymentRequest
        self.metadata = metadata
        self.links = links
        self.fallbackEnabled = fallbackEnabled
        self.fallbackOccurred = fallbackOccurred
        self.signFlowURL = signFlowURL
        self.creditorName = creditorName
        self.actions = actions
        self.resources = resources
    }
}

/// Represents the status of a billing request
public enum BillingRequestStatus: String, Codable {
    /// the billing request is pending and can be used
    case pending = "pending"
    /// the billing request is ready to fulfil
    case ready_to_fulfil = "ready_to_fulfil"
    /// the billing request is currently undergoing fulfilment
    case fulfilling = "fulfilling"
    /// the billing request has been fulfilled and a payment created
    case fulfilled = "fulfilled"
    /// the billing request has been cancelled
    case cancelled = "cancelled"
    /// the billing request has been cancelled and cannot be used
    case unknown = "unknown"
}
