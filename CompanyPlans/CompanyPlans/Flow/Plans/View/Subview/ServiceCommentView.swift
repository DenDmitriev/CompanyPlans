//
//  ServiceCommentView.swift
//  CompanyPlans
//
//  Created by Denis Dmitriev on 14.01.2024.
//

import SwiftUI

struct ServiceCommentView: View {
    
    @Binding var isAppeared: Bool
    
    static let commentShort = "You can always manage your subscription, cancel and renew it in your account"
    
    static let commentAdditional = "You’ll get a full refund if you decide to cancel anytime within the first five days of a monthly subscription."
    
    var body: some View {
        VStack(spacing: AppGrid.pt12) {
            Text(Self.commentShort)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            if isAppeared {
                Text(Self.commentAdditional)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .foregroundStyle(Color.gray2)
        .font(.appCaption).fontWeight(.medium)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    ServiceCommentView(isAppeared: .constant(true))
}
