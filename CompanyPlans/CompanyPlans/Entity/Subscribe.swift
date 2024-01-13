//
//  Subscribe.swift
//  CompanyPlans
//
//  Created by Denis Dmitriev on 12.01.2024.
//

import Foundation

struct Subscribe: Codable {
    let name: String
    let price: Int
    let services: [Service]
    let button: String
}

struct Service: Codable {
    let isEnable: Bool
    let description: String
}
