//
//  PlansView.swift
//  CompanyPlans
//
//  Created by Denis Dmitriev on 13.01.2024.
//

import SwiftUI

struct PlansView: View {
    
    @StateObject var viewModel: PlansViewModel
    @State var subscribes: [Subscribe]?
    @State private var isShowDetail: Bool = false
    @State private var selectedItem: Subscribe?
    /// Значение `isShowDetail` уже после появления
    @State private var isAppeared = false
    static private let header = "Sign up for a subscription to access all the app's features"
    
    @State private var isAnimating = false
    @Namespace var animation
    
    var body: some View {
        NavigationStack(path: $viewModel.path) {
            ScrollView {
                VStack(spacing: AppGrid.pt12) {
                    if let subscribes {
                        Text(Self.header)
                            .font(.appHeader)
                            .padding(.horizontal, AppGrid.pt12)
                            .padding(.top, AppGrid.pt22)
                        
                            ForEach(subscribes) { subscribe in
                                PlanItem(
                                    subscribe: subscribe,
                                    isShowDetail: $isShowDetail,
                                    isAppeared: $isAppeared,
                                    animation: animation
                                )
                                .onTapGesture {
                                    selectedItem = subscribe
                                    withAnimation {
                                        isShowDetail.toggle()
                                    }
                                }
                                .shadow(color: .black.opacity(0.05), radius: AppGrid.pt16, y: AppGrid.pt4)
                                .padding(.horizontal, AppGrid.pt12)
                            }
//                            .background(.pink)
                    } else {
                        placeholder
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Company Plans")
                        .font(.appTitle3)
                }
            }
            .navigationDestination(for: PlansRouter.self) { route in
                viewModel.build(route: route)
            }
        }
        .background(.backgroundTwo)
        .onAppear {
            viewModel.fetchPlans()
        }
        .onReceive(viewModel.$subscribes) { subscribes in
            self.subscribes = subscribes
        }
        .alert(isPresented: $viewModel.hasError, error: viewModel.error) { error in
            Button("Ok", action: { print("error alert dismiss") })
        } message: { error in
            if let message = error.failureReason {
                Text(message)
            }
        }
        .overlay {
            if isShowDetail {
                PlanItemDetail(
                    subscribe: selectedSubscribe(),
                    isShowDetail: $isShowDetail,
                    isAppeared: $isAppeared,
                    animation: animation
                )
            }
        }
        .environmentObject(viewModel)
    }
    
    private var placeholder: some View {
        Text("Subscribes are not available")
            .multilineTextAlignment(.center)
            .foregroundStyle(.secondary)
            .font(.appTitle)
            .padding()
    }
    
    private func selectedSubscribe() -> Binding<Subscribe> {
        Binding<Subscribe>(get: {
            selectedItem ?? .placeholder
        }) { subscribe in
            if let selectedItem, let index = subscribes?.firstIndex(where: { $0.id == selectedItem.id }) {
                subscribes?[index] = selectedItem
            }
        }
    }
}

#Preview {
    PlansView(viewModel: PlansViewModel())
}
