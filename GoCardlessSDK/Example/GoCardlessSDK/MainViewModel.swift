//
//  MainViewModel.swift
//  GoCardlessSDK_Example
//
//  Created by Gunhan Sancar on 25/01/2024.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import SwiftUI
import GoCardlessSDK
import Combine

enum MainViewState {
    case idle
    case loading
    case error
    case success(url: String)
}

@MainActor
class MainViewModel: ObservableObject {
    @Published var state: MainViewState = .idle
    
    var subscriptions = Set<AnyCancellable>()
    
    func createSinglePayment() {
        state = .loading
        print("Create IBP Payment")
        
        let br = BillingRequest.init(
            paymentRequest : PaymentRequest.init(description: "Test", currency: "GBP", amount: 100)
        )
        createBR(br: br)
    }
    
    func createMandate() {
        state = .loading
        print("Create Mandate")
        
        let br = BillingRequest.init(
            mandateRequest : MandateRequest.init(currency: "GBP", description: "Test")
        )
        createBR(br: br)
    }
    
    func createVRPMandate() {
        state = .loading
        print("Create Mandate")
        
        let br = BillingRequest.init(
            mandateRequest : MandateRequest.init(
                currency: "GBP",
                constraints : MandateConstraints.init(
                    periodicLimits : [
                        PeriodicLimit.init(
                            period : Period.month,
                            maxTotalAmount : 100
                        )
                    ],
                    maxAmountPerPayment : 100
                ),
                scheme: "faster_payments",
                sweeping : true,
                description: "Test"
            )
        )
        createBR(br: br)
    }
    
    private func createBR(br: BillingRequest) {
        state = .loading
        print("Create Billing Request")
        
        GoCardlessSDK.shared.billingRequestService.createBillingRequest(billingRequest: br)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { (completion) in
                switch completion {
                case let .failure(error):
                    print("API error: \(error)")
                    self.state = .error
                case .finished: break
                }
            }) { billingRequest in
                self.createBRF(brId: billingRequest.id!)
            }
            .store(in: &subscriptions)
    }
    
    private func createBRF(brId: String) {
        print("Create Billing Request Flow")
        
        let brf = BillingRequestFlow.init(
            links: Links.init(billingRequest: brId)
        )
        
        GoCardlessSDK.shared.billingRequestFlowService.createBillingRequestFlow(
            billingRequestFlow: brf)
        .receive(on: DispatchQueue.main)
        .sink(receiveCompletion: { (completion2) in
            switch completion2 {
            case let .failure(error):
                print("API error: \(error)")
                self.state = .error
            case .finished:
                break
            }
        }) { billingRequestFlow in
            self.state = .success(url: billingRequestFlow.authorisationURL!)
            UIApplication.shared.open(URL(string: billingRequestFlow.authorisationURL!)!)
        }
        .store(in: &subscriptions)
        
    }
}
