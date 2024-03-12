import XCTest
import Combine
import Nimble
@testable import GoCardlessSDK

class BillingRequestFlowTests: XCTestCase {
    private let headerProvider = HttpHeaderProvider(accessToken: "")
    private var httpClient: HttpClient!
    private var billingRequestFlowService: BillingRequestFlowService!
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
        billingRequestFlowService = BillingRequestFlowService(httpClient: httpClient)
    }
    
    override func tearDown() {
        cancellables = nil
        URLProtocolStub.testURLs.removeAll()
        super.tearDown()
    }
    
    func test_billing_request_flow_create() {
        // Given
        URLProtocolStub.successStub(endpoint: .billingRequestFlowCreate, fileName: "billing_request_flow_success")
        let expectation = XCTestExpectation(description: "HttpClient request")
        var result: BillingRequestFlow? = nil
        
        // When
        billingRequestFlowService.createBillingRequestFlow(billingRequestFlow: BillingRequestFlow())
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
        expect(result?.id).to(equal("BRF0002HJNHHDSCF4F5XEJE61E94AMAX"))
        expect(result?.links?.billingRequest).to(equal("BRQ0005VSWHP5JE"))
        expect(result?.redirectURI).to(equal("https://gocardless.com/"))
        expect(result?.exitURI).to(equal("https://developer.gocardless.com/"))
        expect(result?.lockCustomerDetails).to(equal(false))
    }
    
    func test_billing_request_flow_error() {
        // Given
        URLProtocolStub.errorStub(endpoint: .billingRequestFlowCreate, fileName: "billing_request_flow_error")
        let expectation = XCTestExpectation(description: "HttpClient request")
        var result: Error? = nil
        
        // When
        billingRequestFlowService.createBillingRequestFlow(billingRequestFlow: BillingRequestFlow())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    result = error
                    expectation.fulfill()
                case .finished:
                    XCTFail("Unexpected result")
                }
            }, receiveValue: { data in
            })
            .store(in: &cancellables)
        wait(for: [expectation], timeout: 1.0)
        
        // Then
        expect(result).to(matchError(APIError.notFound))
    }
}
