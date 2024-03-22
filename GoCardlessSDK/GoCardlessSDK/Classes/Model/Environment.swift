//
//  Environment.swift
//  GoCardlessSDK
//
//  Created by Gunhan Sancar on 26/01/2024.
//

@objc(Environment)
public enum Environment: Int {
    case sandbox
    case live
    
    var baseUrl: String {
        switch self {
        case .sandbox: return "https://api-sandbox.gocardless.com"
        case .live: return "https://api.gocardless.com"
        }
    }
}
