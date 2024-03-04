//
//  CustomerDetailView.swift
//  GoCardlessSDK_Example
//
//  Created by Gunhan Sancar on 26/01/2024.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import SwiftUI
import GoCardlessSDK

struct CustomerDetailView: View {
    let customer: Customer
    
    init(customer: Customer) {
        self.customer = customer
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Customer details")
            VStack(alignment: .leading) {
                HStack {
                    Text("\(customer.givenName) \(customer.familyName)")
                    Spacer()
                }
                
                Text("Address")
                    .font(.system(size: 12))
                
                Text("\(customer.fullAddress())")
                    .font(.system(size: 12))
            }
            Text("Bank accounts")
                .padding(.top, 20)
            Spacer()
        }
        .padding(20)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        
    }
}
