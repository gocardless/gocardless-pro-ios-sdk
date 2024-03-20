//
//  BillingRequestService.swift
//  GoCardlessSDK
//
//

import Foundation
import Combine

/**
 * A Billing Request enables you to collect all types of GoCardless payments using
 * the Billing Request Flow API. This includes both one-off and recurring payments
 * from your new or existing customers.
 */
public class BillingRequestService {
    private let httpClient: HttpClient
    
    init(httpClient: HttpClient) {
        self.httpClient = httpClient
    }
    
    /**
     Creates a Billing Request, enabling you to collect all types of GoCardless payments using
     the Billing Request Flow API. This includes both one-off and recurring payments
     from your new or existing customers.
     
     - Parameter billingRequest: The Billing Request to create.
     */
    public func createBillingRequest(billingRequest: BillingRequest) -> AnyPublisher<BillingRequest, Error> {
        let endpoint = Endpoint.billingRequestCreate(body: BillingRequestWrapper(billingRequests: billingRequest))
        
        return httpClient.request(endpoint: endpoint)
            .decode(type: BillingRequestWrapper.self, decoder: JSONDecoder())
            .map { $0.billingRequests ?? billingRequest }
            .eraseToAnyPublisher()
    }
    
    /**
     If the billing request has a pending collect_customer_details action,
     this endpoint can be used to collect the details in order to complete it.
     
     The endpoint takes the same payload as Customers, but checks that the customer
     fields are populated correctly for the billing request scheme.
     
     Whatever is provided to this endpoint is used to update the referenced customer,
     and will take effect immediately after the request is successful.
     
     - Parameter billingRequestId The Billing Request to collect customer details.
     - Parameter collectCustomerDetails Customer and their billing details
     */
    public func collectCustomerDetails(billingRequestId: String,
                                       collectCustomerDetails: CollectCustomerDetailsRequest) -> AnyPublisher<BillingRequest, Error> {
        let endpoint = Endpoint.actionCollectCustomerDetails(billingRequestId: billingRequestId,
                                                             body: GenericRequest(data: collectCustomerDetails))
        
        return httpClient.request(endpoint: endpoint)
            .decode(type: BillingRequestWrapper.self, decoder: JSONDecoder())
            .map { $0.billingRequests ?? BillingRequest() }
            .eraseToAnyPublisher()
    }
    
    /**
     If the billing request has a pending collect_bank_account action,
     this endpoint can be used to collect the details in order to complete it.
     
     The endpoint takes the same payload as Customer Bank Accounts,
     but check the bank account is valid for the billing request scheme before creating and attaching it.
     
     If the scheme is PayTo and the pay_id is available,
     this can be included in the payload along with the country_code.
     
     - Parameter billingRequestId The Billing Request to collect bank account.
     - Parameter collectBankAccount Customer bank account details
     */
    public func collectBankAccount(billingRequestId: String,
                                   collectBankAccount: CollectBankAccount) -> AnyPublisher<BillingRequest, Error> {
        let endpoint = Endpoint.actionCollectBankAccount(billingRequestId: billingRequestId, 
                                                         body: GenericRequest(data: collectBankAccount))

        return httpClient.request(endpoint: endpoint)
            .decode(type: BillingRequestWrapper.self, decoder: JSONDecoder())
            .map { $0.billingRequests ?? BillingRequest() }
            .eraseToAnyPublisher()
    }
    
    /**
     This is needed when you have a mandate request. As a scheme compliance rule we are
     required to allow the payer to crosscheck the details entered by them and confirm it.
     
     - Parameter billingRequestId The Billing Request to confirm payer details.
     - Parameter confirmPayerDetailsRequest Payer details
     */
    public func confirmPayerDetails(billingRequestId: String,
                                    confirmPayerDetailsRequest: ConfirmPayerDetailsRequest) -> AnyPublisher<BillingRequest, Error> {
        let endpoint = Endpoint.actionConfirmPayerDetails(billingRequestId: billingRequestId, 
                                                          body: GenericRequest(data: confirmPayerDetailsRequest))

        return httpClient.request(endpoint: endpoint)
            .decode(type: BillingRequestWrapper.self, decoder: JSONDecoder())
            .map { $0.billingRequests ?? BillingRequest() }
            .eraseToAnyPublisher()
    }
    
    /**
     If a billing request is ready to be fulfilled, call this endpoint to cause it to fulfil,
     executing the payment.
     
     - Parameter billingRequestId The Billing Request to be fulfilled.
     - Parameter metaData Key-value store of custom data. Up to 3 keys are permitted, with key names up to 50 characters and values up to 500 characters.
     */
    public func fulfil(billingRequestId: String, metadata: Metadata? = nil) -> AnyPublisher<BillingRequest, Error> {
        let endpoint = Endpoint.actionFulfil(billingRequestId: billingRequestId, body: GenericRequest(data: metadata))

        return httpClient.request(endpoint: endpoint)
            .decode(type: BillingRequestWrapper.self, decoder: JSONDecoder())
            .map { $0.billingRequests ?? BillingRequest() }
            .eraseToAnyPublisher()
    }
    
    /**
     Immediately cancels a billing request, causing all billing request flows to expire.
     
     - Parameter billingRequestId The Billing Request to be cancelled.
     - Parameter metaData Key-value store of custom data. Up to 3 keys are permitted, with key names up to 50 characters and values up to 500 characters.
     */
    public func cancel(billingRequestId: String, metadata: Metadata? = nil) -> AnyPublisher<BillingRequest, Error> {
        let endpoint = Endpoint.actionCancel(billingRequestId: billingRequestId, body: GenericRequest(data: metadata))

        return httpClient.request(endpoint: endpoint)
            .decode(type: BillingRequestWrapper.self, decoder: JSONDecoder())
            .map { $0.billingRequests ?? BillingRequest() }
            .eraseToAnyPublisher()
    }
    
    /**
     Notifies the customer linked to the billing request, asking them to authorise it.
     Currently, the customer can only be notified by email.
     
     This endpoint is currently supported only for Instant Bank Pay Billing Requests.
     
     - Parameter billingRequestId The Billing Request to be notified.
     - Parameter notifyActionRequest Notification body.
     */
    public func notify(billingRequestId: String, metadata: Metadata? = nil) -> AnyPublisher<BillingRequest, Error> {
        let endpoint = Endpoint.actionNotify(billingRequestId: billingRequestId, body: GenericRequest(data: metadata))

        return httpClient.request(endpoint: endpoint)
            .decode(type: BillingRequestWrapper.self, decoder: JSONDecoder())
            .map { $0.billingRequests ?? BillingRequest() }
            .eraseToAnyPublisher()
    }
}
