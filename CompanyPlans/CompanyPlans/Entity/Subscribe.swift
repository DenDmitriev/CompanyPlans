//
//  Subscribe.swift
//  CompanyPlans
//
//  Created by Denis Dmitriev on 12.01.2024.
//

import Foundation

struct SubscribeWrapper: Codable {
    let subscribes: [Subscribe]
}

struct Subscribe: Codable {
    let plan: PlanSubscribe
    let price: Int
    var services: [Service]
    let description: String
    let button: String
}

extension Subscribe: Identifiable {
    var id: PlanSubscribe {
        self.plan
    }
}

extension Subscribe: Equatable {
    static func == (lhs: Subscribe, rhs: Subscribe) -> Bool {
        lhs.id == rhs.id
    }
}

extension Subscribe: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }
}

extension Subscribe {
    static var empty: Self {
        .init(plan: .standard, price: 0, services: [], description: "", button: "")
    }
    
    static var placeholder: Self {
        guard let url = Bundle.main.url(forResource: "Subscribes", withExtension: "json")
        else { return .empty }
        do {
            let data = try Data(contentsOf: url)
            let result = try JSONDecoder().decode(SubscribeWrapper.self, from: data)
            return result.subscribes.first ?? .empty
        } catch {
            print(error.localizedDescription)
            return .empty
        }
    }
}
