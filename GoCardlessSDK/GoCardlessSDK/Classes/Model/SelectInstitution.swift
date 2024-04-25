//
//  SelectInstitution.swift
//  GoCardlessSDK
//
//  Created by Olga Dominguez Gil on 23/04/2024.
//

public struct SelectInstitution: Codable {
    let countryCode: String?
    let institution: String?
    
    enum CodingKeys: String, CodingKey {
        case countryCode = "country_code"
        case institution = "institution"
    }
    
    public init(
        countryCode: String? = nil,
        institution: String? = nil) {
        self.countryCode = countryCode
        self.institution = institution
    }
}
