import XCTest
import Combine
import Nimble
@testable import GoCardlessSDK

class BillingRequestTests: XCTestCase {
    private let headerProvider = HttpHeaderProvider(accessToken: "")
    private var httpClient: HttpClient!
    private var billingRequestService: BillingRequestService!
    private var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        cancellables = []
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [URLProtocolStub.self]
        let urlSession = URLSession.init(configuration: configuration)
        httpClient = HttpClient(httpHeaderProvider: headerProvider,
                                envrionment: TestConstants.environment,
                                urlSession: urlSession)
        billingRequestService = BillingRequestService(httpClient: httpClient)
    }
    
    override func tearDown() {
        cancellables = nil
        URLProtocolStub.testURLs.removeAll()
        super.tearDown()
    }
    
    func test_billing_request_direct_debit_only() {
        // Given
        URLProtocolStub.successStub(endpoint: .billingRequestCreate, fileName: "billing_request_direct_debit_only")
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
        expect(result?.status).to(equal("pending"))
        expect(result?.paymentRequest).to(beNil())
        expect(result?.mandateRequest?.currency).to(equal("GBP"))
        expect(result?.mandateRequest?.metadata?["postman"]).to(equal("mandate-only-br"))
        expect(result?.links?.customerBillingDetail).to(equal("CBD000J8BXKD056"))
        expect(result?.resources?.customer?.id).to(equal("CU001443JPMNCT"))
    }
    
    func test_billing_request_payment_only() {
        // Given
        URLProtocolStub.successStub(endpoint: .billingRequestCreate, fileName: "billing_request_payment_only")
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
        expect(result?.status).to(equal("pending"))
        expect(result?.mandateRequest).to(beNil())
        expect(result?.paymentRequest?.currency).to(equal("GBP"))
        expect(result?.paymentRequest?.metadata?["postman"]).to(equal("payment-only-br"))
        expect(result?.links?.customerBillingDetail).to(equal("CBD000J8BXSXQGK"))
        expect(result?.resources?.customer?.id).to(equal("CU001443JYM9YT"))
    }
    
    func test_billing_request_dual_flow() {
        // Given
        URLProtocolStub.successStub(endpoint: .billingRequestCreate, fileName: "billing_request_dual_flow")
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
        expect(result?.status).to(equal("pending"))
        expect(result?.mandateRequest?.currency).to(equal("GBP"))
        expect(result?.mandateRequest?.metadata?["postman"]).to(equal("payment-mandate-br"))
        expect(result?.paymentRequest?.currency).to(equal("GBP"))
        expect(result?.paymentRequest?.metadata?["postman"]).to(equal("payment-mandate-br"))
        expect(result?.links?.customerBillingDetail).to(equal("CBD000J8BYAEFK1"))
        expect(result?.resources?.customer?.id).to(equal("CU001443KK5AGJ"))
    }
    
    func test_billing_request_error() {
        // Given
        URLProtocolStub.errorStub(endpoint: .billingRequestCreate, fileName: "billing_request_error")
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
        expect(result).to(matchError(APIError.notFound))
    }
}
