//
//  GenericRequest.swift
//  GoCardlessSDK
//
//  Created by Gunhan Sancar on 18/03/2024.
//

struct GenericRequest<T: Codable>: Codable {
    public let data: T?

    enum CodingKeys: String, CodingKey {
        case data = "data"
    }
    
    init(data: T? = nil) {
        self.data = data
    }
}
