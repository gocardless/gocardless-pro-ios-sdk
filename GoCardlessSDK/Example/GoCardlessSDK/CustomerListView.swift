//
//  CustomerListView.swift
//  GoCardlessSDK_Example
//
//  Created by Gunhan Sancar on 24/01/2024.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import SwiftUI
import GoCardlessSDK

struct CustomerListView: View {
    let customers: Customers
    let onDelete: (Customer) -> Void
    let onRefresh: () -> Void
    
    @available(iOS 15.0, *)
    var body: some View {
        List(customers.customers) { customer in
            NavigationLink(destination: CustomerDetailView(customer: customer)) {
                CustomerRow(customer: customer, onDelete: onDelete)
            }
            
        }
        .refreshable {
            print("Refreshing")
            onRefresh()
        }
    }
}

struct CustomerRow: View {
    let customer: Customer
    let onDelete: (Customer) -> Void
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                HStack {
                    Text("\(customer.givenName ?? "") \(customer.familyName ?? "")")
                    Spacer()
                }
                
                Text("Address")
                    .font(.system(size: 12))
                
                Text("\(customer.fullAddress())")
                    .font(.system(size: 12))
            }
            
            Spacer()
            
            Button(action: {
                print("delete")
                onDelete(customer)
            }) {
                Text("Delete")
                    .foregroundColor(.blue)
            }.buttonStyle(PlainButtonStyle())
            
        }
    }
}
