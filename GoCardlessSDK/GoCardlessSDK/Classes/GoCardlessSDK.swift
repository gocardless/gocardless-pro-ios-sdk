//
//  GoCardlessSDK.swift
//  GoCardlessSDK
//
//  Created by Gunhan Sancar on 24/01/2024.
//

import Foundation

@objc(GoCardlessSDK)
public class GoCardlessSDK: NSObject {
    public static let shared = GoCardlessSDK()
    
    private var container: DependencyContainer = DependencyContainer()
    private var initialised: Bool = false
    
    public private(set) lazy var customerService: CustomerService = container.resolve()
    
    /// Initialise the GoCardless SDK
    ///
    /// - Parameter accessToken: The access token
    /// - Parameter completion: Callback closure to be notified once the initialisation is done
    @objc
    public static func initSDK(accessToken: String,
                               environment: Environment,
                               completion: (() -> Void)? = nil) {
        shared.initSDK(accessToken: accessToken, 
                       environment: environment,
                       completion: completion)
    }
    
    private func initSDK(accessToken: String,
                         environment: Environment,
                         completion: (() -> Void)? = nil) {
        guard !initialised else { return }
        registerDependencies(accessToken: accessToken, environment: environment)
        initialised = true
        completion?()
    }
    
    private func registerDependencies(accessToken: String, environment: Environment) {
        container.single(HttpHeaderProvider.self) { _, _  in
            HttpHeaderProvider(accessToken: accessToken)
        }
        container.single(HttpClient.self) { _, _  in
            HttpClient(httpHeaderProvider: self.container.resolve(), envrionment: environment)
        }
        container.single(CustomerService.self) { _, _  in
            CustomerService(httpClient: self.container.resolve())
        }
    }
}
