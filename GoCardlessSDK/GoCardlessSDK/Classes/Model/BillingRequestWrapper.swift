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
    public let meta: Metadata?
    
    enum CodingKeys: String, CodingKey {
        case billingRequests = "billing_requests"
        case meta = "meta"
    }
    
    public init(billingRequests: [BillingRequest]? = nil, meta: Metadata? = nil) {
        self.billingRequests = billingRequests
        self.meta = meta
    }
}

public struct BillingRequestListMetadata: Codable {
    public let cursors: BillingRequestListMetadataCursors?
    public let limit: String?
    
    enum CodingKeys: String, CodingKey {
        case cursors = "cursors"
        case limit = "limit"
    }
    
    public init(cursors: BillingRequestListMetadataCursors? = nil, limit: String? = nil) {
        self.cursors = cursors
        self.limit = limit
    }
}

public struct BillingRequestListMetadataCursors: Codable {
    public let before: String?
    public let after: String?
    
    enum CodingKeys: String, CodingKey {
        case before = "before"
        case after = "after"
    }
    
    public init(before: String? = nil, after: String? = nil) {
        self.before = before
        self.after = after
    }
}
