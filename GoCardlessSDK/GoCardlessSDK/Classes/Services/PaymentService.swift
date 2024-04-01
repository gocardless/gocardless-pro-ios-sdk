//
//  PaymentService.swift
//  GoCardlessSDK
//
//  Created by Gunhan Sancar on 01/04/2024.
//

import Foundation
import Combine

/**
 * Payment objects represent payments from a customer to a creditor, taken against a Direct Debit mandate.
 */
public class PaymentService {
    private let httpClient: HttpClient
    
    init(httpClient: HttpClient) {
        self.httpClient = httpClient
    }
    
    /**
     Creates a new payment object.
     
     This fails with a mandate_is_inactive error if the linked mandate is cancelled or has failed.
     Payments can be created against mandates with status of: pending_customer_approval,
     pending_submission, submitted, and active.
     
     - Parameter payment: The Payment Request to create.
     */
    public func createPayment(payment: Payment) -> AnyPublisher<Payment, Error> {
        let endpoint = Endpoint.paymentCreate(payment: PaymentWrapper(payments: payment))
        
        return httpClient.request(endpoint: endpoint)
            .decode(type: PaymentWrapper.self, decoder: JSONDecoder())
            .map { $0.payments ?? payment }
            .eraseToAnyPublisher()
    }
    
    /**
     Retrieves the details of a single existing payment.
     
     - Parameter paymentId The Payment Id.
     */
    public func getPayment(paymentId: String) -> AnyPublisher<Payment, APIError> {
        let endpoint = Endpoint.paymentGet(paymentId: paymentId)

        return httpClient.request(endpoint: endpoint)
            .decode(type: PaymentWrapper.self, decoder: JSONDecoder())
            .map { $0.payments ?? Payment() }
            .mapError { error in
                if let apiError = error as? APIError {
                    return apiError
                } else {
                    return APIError.malformedResponseError
                }
            }
            .eraseToAnyPublisher()
    }
}

