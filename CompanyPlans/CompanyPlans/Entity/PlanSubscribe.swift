//
//  PlanSubscribe.swift
//  CompanyPlans
//
//  Created by Denis Dmitriev on 13.01.2024.
//

import Foundation

enum PlanSubscribe: String, Codable {
    case standard = "Standard"
    case premium = "Premium"
    
    var name: String {
        self.rawValue
    }
}
