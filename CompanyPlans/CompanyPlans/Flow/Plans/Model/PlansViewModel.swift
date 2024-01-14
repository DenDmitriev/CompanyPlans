//
//  PlansViewModel.swift
//  CompanyPlans
//
//  Created by Denis Dmitriev on 13.01.2024.
//

import SwiftUI

class PlansViewModel: ObservableObject {
    @Published var path = NavigationPath()
    @Published var subscribes: [Subscribe]?
    @Published var error: PlansError?
    @Published var hasError: Bool = false
    
    // MARK: - Data
    /// Mock Subscribe plans
    func fetchPlans() {
        guard let url = Bundle.main.url(forResource: "Subscribes", withExtension: "json")
        else { return }
        
        do {
            let data = try Data(contentsOf: url)
            let result = try JSONDecoder().decode(SubscribeWrapper.self, from: data)
            let subscribes = result.subscribes
            DispatchQueue.main.async {
                self.subscribes = subscribes
            }
        } catch {
            self.error(error)
        }
    }
    
    // MARK: - Navigation
    func build(route: PlansRouter) -> some View {
        route.view()
    }
    
    func push(_ page: PlansRouter) {
        path.append(page)
    }
    
    func pop() {
        path.removeLast()
    }
        
    // MARK: - Private
    private func error(_ error: Error) {
        let error = error as NSError
        DispatchQueue.main.async {
            self.error = PlansError.map(errorDescription: error.localizedDescription, failureReason: error.localizedFailureReason)
            self.hasError = true
        }
    }
}
