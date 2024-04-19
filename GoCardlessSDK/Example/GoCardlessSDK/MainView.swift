//
//  MainView.swift
//  GoCardlessSDK_Example
//
//  Created by Gunhan Sancar on 24/01/2024.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import SwiftUI
import GoCardlessSDK

struct MainView: View {
    @StateObject var viewModel = MainViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                switch viewModel.state {
                case .idle:
                    Text("")
                case .loading:
                    Text("Loading...")
                case .success:
                    Text("Launching")
                case .error:
                    Text("Oops... Something went wrong")
                }
                
                Button("Create Single Payment") {
                    viewModel.createSinglePayment()
                }
                
                Spacer()
                
                Button("Create DD Mandate") {
                    viewModel.createMandate()
                }
                
                Spacer()
                
                Button("Create VRP Mandate") {
                    viewModel.createVRPMandate()
                }
            }
        }
    }
}

