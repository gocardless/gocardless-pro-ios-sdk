//
//  Views.swift
//  GoCardlessSDK_Example
//
//  Created by Olga Dominguez Gil on 19/04/2024.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import SwiftUI
import GoCardlessSDK

struct BillingRequestView: View {
    let br: BillingRequest
    
    var body: some View {
        HStack {
            Text(br.id!)
        }
    }
}
