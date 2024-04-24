import XCTest
import Combine
import Nimble
@testable import GoCardlessSDK

class BillingRequestTests: XCTestCase {
    private let headerProvider = HttpHeaderProvider(accessToken: "")
    private var httpClient: HttpClient!
    private var billingRequestService: BillingRequestService!
    private var cancellables: Set<AnyCancellable>!
    private var billingEndpoint = Endpoint.billingRequestCreate(body: BillingRequestWrapper(billingRequests: BillingRequest()))
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
        billingRequestService = BillingRequestService(httpClient: httpClient)
    }
    
    override func tearDown() {
        cancellables = nil
        URLProtocolStub.testURLs.removeAll()
        super.tearDown()
    }
    
    func test_billing_request_direct_debit_only() {
        // Given
        URLProtocolStub.successStub(endpoint: billingEndpoint, fileName: "billing_request_direct_debit_only")
        let expectation = XCTestExpectation(description: "HttpClient request")
        var result: BillingRequest? = nil
        
        // When
        billingRequestService.createBillingRequest(billingRequest: BillingRequest())
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
        expect(result?.status).to(equal(BillingRequestStatus.pending))
        expect(result?.paymentRequest).to(beNil())
        expect(result?.mandateRequest?.currency).to(equal("GBP"))
        expect(result?.mandateRequest?.metadata?["postman"]).to(equal("mandate-only-br"))
        expect(result?.links?.customerBillingDetail).to(equal("CBD000J8BXKD056"))
        expect(result?.resources?.customer?.id).to(equal("CU001443JPMNCT"))
    }
    
    func test_billing_request_payment_only() {
        // Given
        URLProtocolStub.successStub(endpoint: billingEndpoint, fileName: "billing_request_payment_only")
        let expectation = XCTestExpectation(description: "HttpClient request")
        var result: BillingRequest? = nil
        
        // When
        billingRequestService.createBillingRequest(billingRequest: BillingRequest())
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
        expect(result?.status).to(equal(BillingRequestStatus.pending))
        expect(result?.mandateRequest).to(beNil())
        expect(result?.paymentRequest?.currency).to(equal("GBP"))
        expect(result?.paymentRequest?.metadata?["postman"]).to(equal("payment-only-br"))
        expect(result?.links?.customerBillingDetail).to(equal("CBD000J8BXSXQGK"))
        expect(result?.resources?.customer?.id).to(equal("CU001443JYM9YT"))
    }
    
    func test_billing_request_dual_flow() {
        // Given
        URLProtocolStub.successStub(endpoint: billingEndpoint, fileName: "billing_request_dual_flow")
        let expectation = XCTestExpectation(description: "HttpClient request")
        var result: BillingRequest? = nil
        
        // When
        billingRequestService.createBillingRequest(billingRequest: BillingRequest())
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
        expect(result?.status).to(equal(BillingRequestStatus.pending))
        expect(result?.mandateRequest?.currency).to(equal("GBP"))
        expect(result?.mandateRequest?.metadata?["postman"]).to(equal("payment-mandate-br"))
        expect(result?.paymentRequest?.currency).to(equal("GBP"))
        expect(result?.paymentRequest?.metadata?["postman"]).to(equal("payment-mandate-br"))
        expect(result?.links?.customerBillingDetail).to(equal("CBD000J8BYAEFK1"))
        expect(result?.resources?.customer?.id).to(equal("CU001443KK5AGJ"))
    }
    
    func test_billing_request_error() {
        // Given
        URLProtocolStub.errorStub(endpoint: billingEndpoint, fileName: "billing_request_error")
        let expectation = XCTestExpectation(description: "HttpClient request")
        var result: Error? = nil
        
        // When
        billingRequestService.createBillingRequest(billingRequest: BillingRequest())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    result = error
                    expectation.fulfill()
                case .finished:
                    expectation.fulfill()
                }
            }, receiveValue: { data in
                XCTFail("Unexpected result")
            })
            .store(in: &cancellables)
        wait(for: [expectation], timeout: 1.0)
        
        // Then
        expect(result).to(matchError(APIError.init(type: APIErrorType.invalidApiUsageError)))
    }
    
    func test_billing_request_action_collect_bank_account() {
        // Given
        let billingRequestId = "BRQ00019RM2676C"
        var metadata = Metadata()
        metadata["name"] = "Investment Account"
        let bankAccount = CollectBankAccount(accountHolderName: "INVESTMENT ACCOUNT",
                                             accountNumber: "55779911",
                                             branchCode: "200000",
                                             countryCode: "GB",
                                             metadata: metadata)
        let endpoint = Endpoint.actionCollectBankAccount(billingRequestId: billingRequestId,
                                                         body: GenericRequest(data: bankAccount))
        URLProtocolStub.successStub(endpoint: endpoint, fileName: "collect_bank_account")
        let expectation = XCTestExpectation(description: "HttpClient request")
        var result: BillingRequest? = nil
        
        // When
        billingRequestService.collectBankAccount(billingRequestId: billingRequestId,
                                                 collectBankAccount: bankAccount)
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
        let actionResult = result?.actions?.filter { $0.type == ActionType.collectBankAccount }.first
        expect(result?.status).to(equal(BillingRequestStatus.pending))
        expect(result?.mandateRequest?.metadata?["key"]).to(equal("value"))
        expect(actionResult?.status).to(equal(ActionStatus.completed))
        expect(actionResult?.requiresActions).to(equal([ActionType.collectAmount.rawValue]))
        expect(actionResult?.completesActions).to(equal([ActionType.chooseCurrency.rawValue]))
        expect(actionResult?.availableCountryCodes).to(equal(["GB"]))
    }
    
    func test_billing_request_action_collect_customer_details() {
        // Given
        let billingRequestId = "BRQ00019RM2676C"
        var metadata = Metadata()
        metadata["name"] = "Investment Account"
        let data = CollectCustomerDetailsRequest()
        let endpoint = Endpoint.actionCollectCustomerDetails(billingRequestId: billingRequestId,
                                                             body: GenericRequest(data: data))
        
        URLProtocolStub.successStub(endpoint: endpoint, fileName: "collect_customer_details")
        let expectation = XCTestExpectation(description: "HttpClient request")
        var result: BillingRequest? = nil
        
        // When
        billingRequestService.collectCustomerDetails(billingRequestId: billingRequestId,
                                                     collectCustomerDetails: data)
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
        let actionResult = result?.actions?.filter { $0.type == ActionType.collectCustomerDetails }.first
        expect(result?.status).to(equal(BillingRequestStatus.pending))
        expect(result?.mandateRequest?.metadata?["key"]).to(equal("value"))
        expect(actionResult?.status).to(equal(ActionStatus.completed))
        expect(actionResult?.requiresActions).to(equal([ActionType.chooseCurrency.rawValue, 
                                                        ActionType.collectAmount.rawValue]))
        expect(actionResult?.completesActions).to(equal([]))
        expect(actionResult?.availableCountryCodes).to(beNil())
    }
    
    func test_billing_request_action_confirm_payer_details() {
        // Given
        let billingRequestId = "BRQ00019S3HW4AA"
        var metadata = Metadata()
        metadata["name"] = "Investment Account"
        let data = ConfirmPayerDetailsRequest()
        let endpoint = Endpoint.actionConfirmPayerDetails(billingRequestId: billingRequestId,
                                                          body: GenericRequest(data: data))
        print(" test: \(endpoint.path)")
        URLProtocolStub.successStub(endpoint: endpoint, fileName: "collect_customer_details")
        let expectation = XCTestExpectation(description: "HttpClient request")
        var result: BillingRequest? = nil
        
        // When
        billingRequestService.confirmPayerDetails(billingRequestId: billingRequestId,
                                                  confirmPayerDetailsRequest: data)
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
        let actionResult = result?.actions?.filter { $0.type == ActionType.confirmPayerDetails }.first
        expect(result?.id).to(equal("BRQ00019RM2676C"))
        expect(result?.status).to(equal(BillingRequestStatus.pending))
        expect(result?.mandateRequest?.metadata?["key"]).to(equal("value"))
        expect(actionResult?.status).to(equal(ActionStatus.pending))
        expect(actionResult?.requiresActions).to(equal([ActionType.collectCustomerDetails.rawValue,
                                                        ActionType.collectBankAccount.rawValue]))
        expect(actionResult?.completesActions).to(equal([]))
        expect(actionResult?.availableCountryCodes).to(beNil())
    }
    
    func test_billing_request_action_fulfil() {
        // Given
        let billingRequestId = "BRQ00019RNXYJ5D"
        var metadata = Metadata()
        metadata["name"] = "Investment Account"
        let endpoint = Endpoint.actionFulfil(billingRequestId: billingRequestId, body: nil)
        URLProtocolStub.successStub(endpoint: endpoint, fileName: "action_fulfil")
        let expectation = XCTestExpectation(description: "HttpClient request")
        var result: BillingRequest? = nil
        
        // When
        billingRequestService.fulfil(billingRequestId: billingRequestId)
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
        expect(result?.id).to(equal(billingRequestId))
        expect(result?.status).to(equal(BillingRequestStatus.fulfilled))
        expect(result?.mandateRequest?.metadata?["key"]).to(equal("value"))
        expect(result?.actions?.count).to(equal(0))
    }
    
    func test_billing_request_action_cancel() {
        // Given
        let billingRequestId = "BRQ0005XEEVPV4B"
        var metadata = Metadata()
        metadata["name"] = "Investment Account"
        let endpoint = Endpoint.actionFulfil(billingRequestId: billingRequestId, body: nil)
        URLProtocolStub.successStub(endpoint: endpoint, fileName: "action_cancel")
        let expectation = XCTestExpectation(description: "HttpClient request")
        var result: BillingRequest? = nil
        
        // When
        billingRequestService.fulfil(billingRequestId: billingRequestId)
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
        expect(result?.id).to(equal(billingRequestId))
        expect(result?.status).to(equal(BillingRequestStatus.cancelled))
        expect(result?.actions?.count).to(equal(0))
    }
    
    func test_billing_request_action_notify() {
        // Given
        let billingRequestId = "BRQ0005XPF8YSR1"
        var metadata = Metadata()
        metadata["name"] = "Investment Account"
        let endpoint = Endpoint.actionFulfil(billingRequestId: billingRequestId, body: nil)
        URLProtocolStub.successStub(endpoint: endpoint, fileName: "action_notify")
        let expectation = XCTestExpectation(description: "HttpClient request")
        var result: BillingRequest? = nil
        
        // When
        billingRequestService.fulfil(billingRequestId: billingRequestId)
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
        expect(result?.id).to(equal(billingRequestId))
        expect(result?.status).to(equal(BillingRequestStatus.pending))
        expect(result?.actions?.count).to(equal(6))
    }
}
