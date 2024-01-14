//
//  CurrencyFormatter.swift
//  CompanyPlans
//
//  Created by Denis Dmitriev on 13.01.2024.
//

import Foundation

struct CurrencyFormatter {
    static let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "KWD"
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 0
        formatter.usesGroupingSeparator = true
        return formatter
    }()
    
    static func formatter(value: NSNumber, add: String) -> String? {
        if let price = formatter.string(from: value) {
            return "\(price) \(add)"
        } else {
            return nil
        }
    }
}
