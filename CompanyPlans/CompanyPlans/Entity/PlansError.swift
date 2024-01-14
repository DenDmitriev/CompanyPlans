//
//  PlansError.swift
//  CompanyPlans
//
//  Created by Denis Dmitriev on 13.01.2024.
//

import Foundation

enum PlansError: Error {
    case map(errorDescription: String?, failureReason: String?)
}

extension PlansError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .map(let errorDescription, _):
            return NSLocalizedString(errorDescription ?? "Unknown error", comment: "Error")
        }
    }
    
    var failureReason: String? {
        switch self {
        case .map(_ ,let failureReason):
            return NSLocalizedString(failureReason ?? "Unknown reason", comment: "Error")
        }
    }
}
