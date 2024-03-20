//
//  BillingRequestActionType.swift
//  GoCardlessSDK
//
//  Created by Gunhan Sancar on 18/03/2024.
//

enum BillingRequestActionType: String, Codable {
    case CollectCustomerDetails = "collect_customer_details"
    case CollectBankAccount = "collect_bank_account"
    case ConfirmPayerDetails = "confirm_payer_details"
    case Fulfil = "fulfil"
    case Cancel = "cancel"
    case Notify = "notify"
}
