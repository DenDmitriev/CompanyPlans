//
//  Service.swift
//  CompanyPlans
//
//  Created by Denis Dmitriev on 13.01.2024.
//

import Foundation

extension Subscribe {
    struct Service: Codable {
        var isEnable: Bool
        var isEditable: Bool
        let description: String
    }
}

extension Subscribe.Service: Identifiable {
    var id: String {
        self.description
    }
}
