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
                    Text("Initial")
                case .loading:
                    Text("Loading...")
                case .success(let customers):
                    CustomerListView(customers: customers, onDelete: {
                        customer in
                        viewModel.deleteCustomer(customer: customer)
                    }, onRefresh: {
                        viewModel.fetchCustomers()
                    })
                case .error:
                    Text("Oops... Something went wrong")
                }
            }
            .onAppear {
                //viewModel.fetchCustomers()
            }
        }
    }
}
