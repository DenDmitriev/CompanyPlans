//
//  PlansView.swift
//  CompanyPlans
//
//  Created by Denis Dmitriev on 13.01.2024.
//

import SwiftUI

struct PlansView: View {
    
    @StateObject var viewModel: PlansViewModel
    @ObservedObject var subscribeList: SubscribeList
    @State private var isShowDetail: Bool = false
    @State private var selectedIndex: Int?
    /// Значение `isShowDetail` уже после появления
    @State private var isAppeared = false
    static private let header = "Sign up for a subscription to access all the app's features"
    
    @State private var isAnimating = false
    @Namespace var animation
    
    init(viewModel: PlansViewModel, subscribeList: SubscribeList = .init(subscribes: [])) {
        self._viewModel = .init(wrappedValue: viewModel)
        self.subscribeList = subscribeList
    }
    
    var body: some View {
        NavigationStack(path: $viewModel.path) {
            Group {
                if isShowDetail, let selectedIndex {
                    PlanItemDetail(
                        subscribe: $subscribeList.subscribes[selectedIndex],
                        isShowDetail: $isShowDetail,
                        isAppeared: $isAppeared,
                        animation: animation
                    )
                } else {
                    ScrollView {
                        VStack(spacing: AppGrid.pt12) {
                            if !subscribeList.subscribes.isEmpty {
                                Text(Self.header)
                                    .font(.appHeader)
                                    .padding(.horizontal, AppGrid.pt12)
                                    .padding(.top, AppGrid.pt24)
                                
                                Spacer()
                                    .frame(height: AppGrid.pt4)
                                
                                ForEach(subscribeList.subscribes.indices, id: \.self) { index in
                                    PlanItem(
                                        subscribe: $subscribeList.subscribes[index],
                                        isShowDetail: $isShowDetail,
                                        isAppeared: $isAppeared,
                                        animation: animation
                                    )
                                    .onTapGesture {
                                        selectedIndex = index
                                        withAnimation {
                                            isShowDetail.toggle()
                                        }
                                    }
                                    .shadow(color: .black.opacity(0.05), radius: AppGrid.pt16, y: AppGrid.pt4)
                                    .padding([.horizontal, .bottom], AppGrid.pt12)
                                }
                            } else {
                                placeholder
                            }
                        }
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
            if let subscribes {
                self.subscribeList.subscribes = subscribes
            }
        }
        .alert(isPresented: $viewModel.hasError, error: viewModel.error) { error in
            Button("Ok", action: { print("error alert dismiss") })
        } message: { error in
            if let message = error.failureReason {
                Text(message)
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
}

#Preview {
    PlansView(viewModel: PlansViewModel(), subscribeList: .init(subscribes: []))
}
