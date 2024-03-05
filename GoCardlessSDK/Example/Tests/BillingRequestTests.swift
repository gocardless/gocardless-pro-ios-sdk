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
    
    func test_billing_request_success() {
        // Given
        URLProtocolStub.successStub(endpoint: .billingRequestCreate, fileName: "billing_request_success")
        let expectation = XCTestExpectation(description: "HttpClient request")
        var result: BillingRequest? = nil
        
        // When
        billingRequestService.createBillingRequest(billingRequest: BillingRequest())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    XCTFail(error.localizedDescription)
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
        expect(result?.paymentRequest?.amount).to(equal(92368))
        expect(result?.links?.customerBillingDetail).to(equal("CBD000HX9F4HFGQ"))
        expect(result?.resources?.customer?.id).to(equal("CU0013N5KS8WW6"))
    }
    
    func test_billing_request_error() {
        // Given
        URLProtocolStub.successStub(endpoint: .billingRequestCreate, fileName: "billing_request_error")
        let expectation = XCTestExpectation(description: "HttpClient request")
        var result: BillingRequest? = nil
        
        // When
        billingRequestService.createBillingRequest(billingRequest: BillingRequest())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("    error: \(error)")
                    XCTFail(error.localizedDescription)
                case .finished:
                    expectation.fulfill()
                }
            }, receiveValue: { data in
                print("    receice: \(data)")
                result = data
            })
            .store(in: &cancellables)
        wait(for: [expectation], timeout: 1.0)
        
        // Then
//        expect(result?.status).to(equal("pending"))
//        expect(result?.paymentRequest?.amount).to(equal(92368))
//        expect(result?.links?.customerBillingDetail).to(equal("CBD000HX9F4HFGQ"))
//        expect(result?.resources?.customer?.id).to(equal("CU0013N5KS8WW6"))
    }
}
