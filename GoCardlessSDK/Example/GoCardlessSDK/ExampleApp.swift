//
//  App.swift
//  GoCardlessSDK_Example
//
//  Created by Gunhan Sancar on 24/01/2024.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import SwiftUI
import GoCardlessSDK

@main
class ExampleApp: App {
    private let accessToken = "sandbox_ReyBZA9xcVZ-ktSxjfG0Duhzr7h-c9Pjt-UTi8RI"
    
    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
    
    required init() {
        GoCardlessSDK.initSDK(accessToken: accessToken, environment: .sandbox) {
            print("GoCardless SDK is initialised")
        }
    }
}
