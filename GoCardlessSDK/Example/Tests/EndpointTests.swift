import XCTest
@testable import GoCardlessSDK

class EndpointTests: XCTestCase {
    func testActionCancel_escapesPathParametersWithinBillingRequestSegment() {
        assertActionCancelPathParameter("../../payments/PM123", isEncodedAs: "%2E%2E%2F%2E%2E%2Fpayments%2FPM123")
        assertActionCancelPathParameter("..", isEncodedAs: "%2E%2E")
        assertActionCancelPathParameter("%2e%2e", isEncodedAs: "%252e%252e")
        assertActionCancelPathParameter("", isEncodedAs: "")
    }

    func testActionCancel_withNewlineInPathParameter_returnsNilURL() {
        let endpoint = Endpoint.actionCancel(billingRequestId: "BR\n123", body: nil)

        XCTAssertNil(endpoint.url(environment: .sandbox))
    }

    private func assertActionCancelPathParameter(_ value: String, isEncodedAs encodedValue: String) {
        let endpoint = Endpoint.actionCancel(billingRequestId: value, body: nil)
        let expectedPath = "/billing_requests/\(encodedValue)/actions/cancel"

        XCTAssertEqual(endpoint.path, expectedPath)

        guard let url = endpoint.url(environment: .sandbox) else {
            XCTFail("Expected a valid URL for path parameter \(value.debugDescription)")
            return
        }

        let normalizedPath = URLComponents(url: url, resolvingAgainstBaseURL: false)?.percentEncodedPath
        XCTAssertEqual(normalizedPath, expectedPath)
        XCTAssertFalse(normalizedPath?.contains("/payments/") ?? true)
    }
}
