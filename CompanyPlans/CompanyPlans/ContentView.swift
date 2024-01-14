//
//  ContentView.swift
//  CompanyPlans
//
//  Created by Denis Dmitriev on 12.01.2024.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        PlansView(viewModel: PlansViewModel())
    }
}

#Preview {
    ContentView()
}
