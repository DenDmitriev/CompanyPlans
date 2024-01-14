//
//  PlansRouter.swift
//  CompanyPlans
//
//  Created by Denis Dmitriev on 14.01.2024.
//

import SwiftUI

enum PlansRouter: Hashable, Identifiable {
    case receipt(subscribe: Subscribe)
    
    var id: Self {
        self
    }
    
    @ViewBuilder
    func view() -> some View {
        switch self {
        case .receipt(let subscribe):
            ReceiptPlanView(subscribe: subscribe)
        }
    }
}
