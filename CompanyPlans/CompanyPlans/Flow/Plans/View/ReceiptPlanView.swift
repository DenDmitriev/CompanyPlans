//
//  SubscribePlanView.swift
//  CompanyPlans
//
//  Created by Denis Dmitriev on 13.01.2024.
//

import SwiftUI

struct ReceiptPlanView: View {
    
    let subscribe: Subscribe
    
    var body: some View {
        VStack(spacing: AppGrid.pt32) {
            ZStack {
                Circle()
                    .fill(.accent)
                    .frame(width: AppGrid.pt96)
                
                Text("🎉")
                    .font(.system(size: AppGrid.pt44))
            }
            
            Text("Congratulations, your \(subscribe.plan.name) subscription has been completed!")
                .font(.appTitle2)
                .multilineTextAlignment(.center)
                .padding(.horizontal, AppGrid.pt12)
        }
        .padding()
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Receipt")
                    .font(.appTitle3)
            }
        }
    }
}

#Preview {
    ReceiptPlanView(subscribe: .placeholder)
}
