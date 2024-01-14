//
//  PlanView.swift
//  CompanyPlans
//
//  Created by Denis Dmitriev on 13.01.2024.
//

import SwiftUI

struct PlanItemDetail: View {
    @EnvironmentObject var viewModel: PlansViewModel
    @Binding var subscribe: Subscribe
    @Binding var isShowDetail: Bool
    @Binding var isAppeared: Bool
    let animation: Namespace.ID
    
    @State private var animateText: Bool = false
    
    var body: some View {
            VStack(spacing: .zero) {
                // Header
                VStack(alignment: .leading, spacing: AppGrid.pt12) {
                    Spacer()
                    
                    Text(subscribe.plan.name)
                        .font(.appLargeTitle)
                        .matchedGeometryEffect(id: AnimationId.title(subscribe.id.rawValue), in: animation)
                    
                    if let priceFormatted = CurrencyFormatter.formatter(value: subscribe.price as NSNumber, add: "/ per month") {
                        Text(priceFormatted)
                            .font(.appTitle3)
                            .matchedGeometryEffect(id: AnimationId.price(subscribe.id.rawValue), in: animation)
                    }
                    
                    Text(subscribe.description)
                        .font(.appBody)
                        .opacity(animateText ? 1 : 0)
                }
                .padding(AppGrid.pt8)
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .frame(maxHeight: UIScreen.main.bounds.height / 3)
                .background {
                    GeometryReader { geometry in
                        Image(headerImage(for: subscribe.plan))
                            .resizable()
                            .matchedGeometryEffect(id: AnimationId.image(subscribe.id.rawValue), in: animation, anchor: .top)
                            .aspectRatio(contentMode: .fill)
                            .frame(maxHeight: geometry.size.height)
                            .clipped()
                    }
                    
                }
                .padding(.bottom, AppGrid.pt8)
                .matchedGeometryEffect(id: AnimationId.header(subscribe.id.rawValue), in: animation)
                
                // Services
                ServicesTogglesView(plan: subscribe.plan, services: subscribe.services)
                    .matchedGeometryEffect(id: AnimationId.toggles(subscribe.id.rawValue), in: animation, anchor: .center)
                    .padding(AppGrid.pt12)
                    .padding(.horizontal, AppGrid.pt12)
                    .frame(maxHeight: .infinity, alignment: .topLeading)
                
                ServiceCommentView(isAppeared: $isAppeared)
                    .padding(.vertical, AppGrid.pt4)
                    .padding(.horizontal, AppGrid.pt16)
                    .matchedGeometryEffect(id: AnimationId.comment(subscribe.id.rawValue), in: animation)
                
                // Actions
                Button(subscribe.button) {
                    viewModel.push(.receipt(subscribe: subscribe))
                    isShowDetail = false
                    isAppeared = false
                }
                .buttonStyle(.fill(color: buttonColor(for: subscribe.plan)))
                .padding(AppGrid.pt12)
                .padding(.top, AppGrid.pt4)
                .matchedGeometryEffect(id: AnimationId.button(subscribe.id.rawValue), in: animation, anchor: .bottom)
                .padding(.bottom, AppGrid.pt36)
            
        }
        .mask {
            RoundedRectangle(cornerRadius: .zero)
                .matchedGeometryEffect(id: AnimationId.backgroundShape(subscribe.id.rawValue), in: animation)
        }
        .background(.background)
        .onAppear {
            withAnimation(.linear) {
                isAppeared = isShowDetail
            }
            withAnimation(.linear.delay(0.2)) {
                animateText = true
            }
        }
        .onDisappear {
            withAnimation(.linear) {
                animateText = false
            }
        }
        .statusBarHidden(true)
        .ignoresSafeArea()
        .overlay(alignment: .topTrailing) {
            Button(action: {
                withAnimation {
                    isAppeared = false
                }
                withAnimation(.hero) {
                    isShowDetail = false
                }
            }, label: {
                Image(systemName: "xmark")
                    .font(.appTitle2)
                    .padding(AppGrid.pt8)
                    .background {
                        Circle()
                            .fill(.ultraThinMaterial)
                    }
            })
            .opacity(animateText ? 1 : 0)
            .padding()
        }
    }
    
    private var placeholder: some View {
        Text("Subscribe are not available")
            .multilineTextAlignment(.center)
            .foregroundStyle(.secondary)
            .font(.appTitle)
            .padding()
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
    
    return PlanItemDetail(subscribe: .constant(.placeholder), isShowDetail: .constant(true), isAppeared: .constant(true), animation: animation)
        .environmentObject(PlansViewModel())
}
