//
//  SubscribesList.swift
//  CompanyPlans
//
//  Created by Denis Dmitriev on 14.01.2024.
//

import Foundation

class SubscribeList: ObservableObject {
    @Published var subscribes: [Subscribe]
    
    init(subscribes: [Subscribe]) {
        self._subscribes = .init(wrappedValue: subscribes)
    }
}
