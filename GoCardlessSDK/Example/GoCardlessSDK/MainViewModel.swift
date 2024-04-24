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
    
    func createCustomPagePayment() {
        state = .loading
        print("Create Custom Page Payment")
        
        let br = BillingRequest.init(
            paymentRequest : PaymentRequest.init(description: "Test", currency: "GBP", amount: 100)
        )
        
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
                self.collectCustomerDetails(br: billingRequest)
            }
            .store(in: &subscriptions)
    }
    
    private func collectCustomerDetails(br: BillingRequest) {
        GoCardlessSDK.shared.billingRequestService.collectCustomerDetails(
            billingRequestId: br.id!,
            collectCustomerDetails: CollectCustomerDetailsRequest.init(
                customer : Customer.init(
                    email : "test@gocardless.com",
                    givenName : "User",
                    familyName : "Test"
                )
            )
        )
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { (completion) in
                switch completion {
                case let .failure(error):
                    print("API error: \(error)")
                    self.state = .error
                case .finished: break
                }
            }) { billingRequest in
                self.selectInstitution(br: billingRequest)
            }
            .store(in: &subscriptions)
    }
    
    private func selectInstitution(br: BillingRequest) {
        GoCardlessSDK.shared.billingRequestService.selectInstitution(
            billingRequestId: br.id!,
            selectInstitution: SelectInstitution.init(
                countryCode : "GB",
                institution : "read_refund_account_sandbox_bank"
            )
        ) .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { (completion) in
                switch completion {
                case let .failure(error):
                    print("API error: \(error)")
                    self.state = .error
                case .finished: break }
            }) { billingRequest in
                self.authorise(br: billingRequest)
            }
            .store(in: &subscriptions)
    }
    
    private func authorise(br: BillingRequest) {
        GoCardlessSDK.shared.billingRequestService.createBankAuthorisation(
            bankAuthorisation: BankAuthorisation.init(links: Links.init(billingRequest: br.id!))
        ).receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { (completion) in
                switch completion {
                case let .failure(error):
                    print("API error: \(error)")
                    self.state = .error
                case .finished: break }
            }) { bankAuthorisation in
                self.state = .success(url: bankAuthorisation.url!)
                UIApplication.shared.open(URL(string:  bankAuthorisation.url!)!)
            }
            .store(in: &subscriptions)
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
