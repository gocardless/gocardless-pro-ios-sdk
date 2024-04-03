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
    case success(customers: Customers)
}

@MainActor
class MainViewModel: ObservableObject {
    @Published var state: MainViewState = .idle
    
    let customerService = GoCardlessSDK.shared.customerService
    var subscriptions = Set<AnyCancellable>()
    
    @MainActor
    func fetchCustomers() {
        state = .loading
        print("Fetch customers")
        
        GoCardlessSDK.shared.billingRequestService.listBillingRequests()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { (completion) in
                switch completion {
                case let .failure(error):
                    print("API error: \(error)")
                    self.state = .error
                case .finished: break
                }
            }) { billingRequestList in
                //self.state = .success(billingRequest: billingRequest)
            }
            .store(in: &subscriptions)
        
        customerService.all()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { (completion) in
                    switch completion {
                    case let .failure(error):
                        print("Couldn't get users: \(error)")
                        self.state = .error
                    case .finished: break
                    }
                }) { customers in
                    self.state = .success(customers: customers)
                }
                .store(in: &subscriptions)
    }
    
    @MainActor
    func deleteCustomer(customer: Customer) {
        state = .loading
        
        let allCustomers = customerService.all()
        
//        customerService.delete(customerId: customer.id ?? "")
//            .receive(on: DispatchQueue.main)
//            .flatMap({ _ in
//                allCustomers
//            })
//            .sink(receiveCompletion: { (completion) in
//                    switch completion {
//                    case let .failure(error):
//                        print("Couldn't get users: \(error)")
//                        self.state = .error
//                    case .finished: break
//                    }
//                }) { customers in
//                    self.state = .success(customers: customers)
//                }
//                .store(in: &subscriptions)
    }
}
