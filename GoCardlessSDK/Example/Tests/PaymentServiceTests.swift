//
//  PaymentServiceTests.swift
//  GoCardlessSDK_Tests
//
//  Created by Gunhan Sancar on 01/04/2024.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import XCTest
import Combine
import Nimble
@testable import GoCardlessSDK

class PaymentServiceTests: XCTestCase {
    private let headerProvider = HttpHeaderProvider(accessToken: "")
    private var httpClient: HttpClient!
    private var service: PaymentService!
    private var cancellables: Set<AnyCancellable>!
    private let errorMapper = ErrorMapper()
    
    override func setUp() {
        super.setUp()
        cancellables = []
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [URLProtocolStub.self]
        let urlSession = URLSession.init(configuration: configuration)
        httpClient = HttpClient(httpHeaderProvider: headerProvider,
                                envrionment: TestConstants.environment,
                                urlSession: urlSession,
                                errorMapper: errorMapper)
        service = PaymentService(httpClient: httpClient)
    }
    
    override func tearDown() {
        cancellables = nil
        URLProtocolStub.testURLs.removeAll()
        super.tearDown()
    }
    
    func test_get_payment_request() {
        // Given
        let paymentId = "PM009ME5BM6SR3"
        let endpoint = Endpoint.paymentGet(paymentId: paymentId)
        URLProtocolStub.successStub(endpoint: endpoint, fileName: "payment_success")
        let expectation = XCTestExpectation(description: "HttpClient request")
        var result: Payment? = nil
        
        // When
        service.getPayment(paymentId: paymentId)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(_):
                    XCTFail("Unexpected result")
                case .finished:
                    expectation.fulfill()
                }
            }, receiveValue: { data in
                result = data
            })
            .store(in: &cancellables)
        wait(for: [expectation], timeout: 1.0)
        
        // Then
        expect(result?.id).to(equal("PM009ME5BM6SR3"))
        expect(result?.amount).to(equal(33197))
        expect(result?.retryIfPossible).to(equal(true))
        expect(result?.status).to(equal(PaymentStatus.pendingSubmission))
        expect(result?.fx?.fxCurrency).to(equal("GBP"))
        expect(result?.links?.mandate).to(equal("MD000ZQFRW73MD"))
        expect(result?.links?.creditor).to(equal("CR00007J0CSSJG"))
    }
    
    func test_create_payment() {
        // Given
        let payment = Payment(
            amount: 123,
            retryIfPossible: true,
            links: PaymentLinks(
                creditor: "CR00007J0CSSJG", 
                mandate: "MD000ZQFRW73MD"
            )
        )
        let enpoint = Endpoint.paymentCreate(payment: PaymentWrapper(payments: payment))
        URLProtocolStub.successStub(endpoint: enpoint, fileName: "payment_success")
        let expectation = XCTestExpectation(description: "HttpClient request")
        var result: Payment? = nil
        
        // When
        service.createPayment(payment: payment)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(_):
                    XCTFail("Unexpected result")
                case .finished:
                    expectation.fulfill()
                }
            }, receiveValue: { data in
                result = data
            })
            .store(in: &cancellables)
        wait(for: [expectation], timeout: 1.0)
        
        // Then
        expect(result?.id).to(equal("PM009ME5BM6SR3"))
        expect(result?.amount).to(equal(33197))
        expect(result?.retryIfPossible).to(equal(true))
        expect(result?.status).to(equal(PaymentStatus.pendingSubmission))
        expect(result?.fx?.fxCurrency).to(equal("GBP"))
        expect(result?.links?.mandate).to(equal("MD000ZQFRW73MD"))
        expect(result?.links?.creditor).to(equal("CR00007J0CSSJG"))
    }
}
