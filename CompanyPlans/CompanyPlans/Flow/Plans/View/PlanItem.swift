//
//  SubscribeItemView.swift
//  CompanyPlans
//
//  Created by Denis Dmitriev on 13.01.2024.
//

import SwiftUI

struct PlanItem: View {
    @EnvironmentObject var viewModel: PlansViewModel
    @Binding var subscribe: Subscribe
    @Binding var isShowDetail: Bool
    @Binding var isAppeared: Bool
    let animation: Namespace.ID
    
    var body: some View {
        VStack(spacing: AppGrid.pt6) {
            // Header
            VStack(alignment: .leading, spacing: AppGrid.pt12) {
                Text(subscribe.plan.name)
                    .font(.appLargeTitle)
                    .matchedGeometryEffect(id: AnimationId.title(subscribe.id.rawValue), in: animation)
                
                if let priceFormatted = CurrencyFormatter.formatter(value: subscribe.price as NSNumber, add: "/ per month") {
                    Text(priceFormatted)
                        .font(.appTitle3)
                        .matchedGeometryEffect(id: AnimationId.price(subscribe.id.rawValue), in: animation)
                }
            }
            .padding(AppGrid.pt8)
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .background {
                GeometryReader { geometry in
                    Image(headerImage(for: subscribe.plan))
                        .resizable()
                        .matchedGeometryEffect(id: AnimationId.image(subscribe.id.rawValue), in: animation, anchor: .top)
                        .aspectRatio(contentMode: .fill)
                        .frame(height: geometry.size.height)
                        .allowsHitTesting(false)
                        .clipped()
                }
            }
            .padding(.bottom, AppGrid.pt8)
            .matchedGeometryEffect(id: AnimationId.header(subscribe.id.rawValue), in: animation)

            // Services
            ServicesTogglesView(plan: subscribe.plan, services: $subscribe.services)
                .matchedGeometryEffect(id: AnimationId.toggles(subscribe.id.rawValue), in: animation)
                .padding(AppGrid.pt12)
            
            // Comments
            ServiceCommentView(isAppeared: $isAppeared)
                .padding(.vertical, AppGrid.pt4)
                .padding(.horizontal, AppGrid.pt16)
                .matchedGeometryEffect(id: AnimationId.comment(subscribe.id.rawValue), in: animation)
            
            // Actions
            Button(subscribe.button) {
                print("subscribe \(subscribe.plan.name) started")
                viewModel.push(.receipt(subscribe: subscribe))
            }
            .buttonStyle(.fill(color: buttonColor(for: subscribe.plan)))
            .padding(AppGrid.pt12)
            .padding(.top, AppGrid.pt4)
            .matchedGeometryEffect(id: AnimationId.button(subscribe.id.rawValue), in: animation, anchor: .bottom)
        }
        .background(.background)
        .mask {
            RoundedRectangle(cornerRadius: AppGrid.pt26)
                .matchedGeometryEffect(id: AnimationId.backgroundShape(subscribe.id.rawValue), in: animation)
            
        }
    }
    
    private func buttonColor(for plan: PlanSubscribe) -> Color {
        switch plan {
        case .standard:
            return .accentColor
        case .premium:
            return .premium
        }
    }
    
    private func headerImage(for plan: PlanSubscribe) -> String {
        switch plan {
        case .standard:
            return "Waves"
        case .premium:
            return "WavesDark"
        }
    }
}

#Preview {
    @Namespace var animation
    
    return PlanItem(subscribe: .constant(.placeholder), isShowDetail: .constant(false), isAppeared: .constant(false), animation: animation)
        .environmentObject(PlansViewModel())
}
