//
//  ProductClientError.swift
//  Odysseia
//
//  Created by lcr on 2020/12/07.
//

enum ProductClientError: Error {
    case canNotMakePayments
    case noProduct
    case invalidProduct
    case failedPurchased
    case failedRestore

    var message: String {
        switch self {
        case .noProduct:
            return "No items available for purchase. Make sure the product ID is correct."
        case .invalidProduct:
            return "There is an invalid product."
        case .canNotMakePayments:
            return "Can not make payments."
        case .failedPurchased:
            return "Failed purchased."
        case .failedRestore:
            return "Failed Restore."
        }
    }
}
