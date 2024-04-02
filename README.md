# GoCardless SDK

The GoCardless iOS SDK is a tool that enables developers to integrate GoCardless payments into their iOS applications. 
To help developers get started, a sample app has been created that demonstrates how to use the SDK. 
The app provides a clear and practical example of how to implement GoCardless payments within an iOS app.

## Getting started

GoCardlessSDK is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'GoCardlessSDK'
```

## Initializing the client

The client is initialised with an access token, and is configured to use GoCardless' live environment by default:

```swift
import GoCardlessSDK

GoCardlessSDK.initSDK(accessToken: "YOUR_ACCESS_TOKEN", environment: .live) {
    print("GoCardless SDK is initialised")
}
```

## Supported Services
Currently we support the following services and their functions

### Billing Request
- `createBillingRequest`: Creates a Billing Request, enabling you to collect all types of GoCardless payments
- `collectCustomerDetails`: If the billing request has a pending collect_customer_details action, this endpoint can be used to collect the details in order to complete it.
- `collectBankAccount`: If the billing request has a pending collect_bank_account action, this endpoint can be used to collect the details in order to complete it.
- `confirmPayerDetails`: This is needed when you have a mandate request. As a scheme compliance rule we are required to allow the payer to crosscheck the details entered by them and confirm it.
- `fulfil`: If a billing request is ready to be fulfilled, call this endpoint to cause it to fulfil, executing the payment.
- `cancel`: Immediately cancels a billing request, causing all billing request flows to expire.
- `notify`: Notifies the customer linked to the billing request, asking them to authorise it.
- `getBillingRequest`: Fetches a billing request
- `listBillingRequests`: Returns a cursor-paginated list of your billing requests.

### Billing Request Flow
- `createBillingRequestFlow`: Creates a new billing request flow.

### Payment
- `createPaymentRequest`: Creates a new payment object.
- ``

## Examples

Note: To be able to make any request, you must initialise the SDK.

### Fetching List of Billing Requests

Ensure that all requests are made within the correct `Scope` before launching.

```swift
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
        self.state = .success(billingRequest: billingRequest)
    }
    .store(in: &subscriptions)
```

### Handling Errors

Whenever the API encounters an issue, it returns a `GoCardlessError` or its derivatives to provide more context about the error. Below are the types of errors you may encounter:

- `AuthenticationError`: Indicates an issue with authentication.
- `GoCardlessInternalError`: Denotes an internal error within the GoCardless system.
- `InvalidApiUsageError`: Occurs when the API is used incorrectly.
- `InvalidStateError`: Indicates an invalid state in the system.
- `MalformedResponseError`: Denotes an issue with the response received from the API.
- `PermissionError`: Occurs when the user does not have the necessary permissions.
- `RateLimitError`: Indicates that the rate limit for API requests has been exceeded.
- `ValidationFailedError`: Denotes a validation failure, usually with user input.


## SDK Requirements

### Language
- **Swift**

### Minimum Deployments
- **iOS 13**

### Dependencies
- **No external libraries**

### Threading
- **Combine**

### Repository
- **[GitHub Repository](https://github.com/gocardless/gocardless-pro-ios-sdk)**
