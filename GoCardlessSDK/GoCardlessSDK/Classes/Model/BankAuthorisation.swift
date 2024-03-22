//
//  BankAuthorisation.swift
//  GoCardlessSDK
//
//

public struct BankAuthorisation: Codable {
    public let authorisationType: String?
    public let adapter: String?

    enum CodingKeys: String, CodingKey {
        case authorisationType = "authorisation_type"
        case adapter = "adapter"
    }

    public init(authorisationType: String?, adapter: String?) {
        self.authorisationType = authorisationType
        self.adapter = adapter
    }
}
