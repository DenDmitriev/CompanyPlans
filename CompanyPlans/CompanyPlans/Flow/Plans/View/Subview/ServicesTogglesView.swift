//
//  ServicesTogglesView.swift
//  CompanyPlans
//
//  Created by Denis Dmitriev on 14.01.2024.
//

import SwiftUI

struct ServicesTogglesView: View {
    let plan: PlanSubscribe
    @Binding var services: [Subscribe.Service]
    
    var body: some View {
        VStack(alignment: .leading, spacing: AppGrid.pt10) {
            ForEach(Array(zip(services.indices, services)), id: \.0) { index, service in
                let isOn: Binding<Bool> = .init(
                    get: { service.isEnable },
                    set: { services[index].isEnable = $0 }
                )
                Toggle(isOn: isOn) {
                    Text(service.description)
                }
                .toggleStyle(.checkMark(color: toggleColor(for: plan)))
                .disabled(!service.isEditable)
                
                if index > .zero, index < services.count - 1,
                   !services[index + 1].isEditable,
                   service.isEditable {
                    Spacer()
                        .frame(height: AppGrid.pt4)
                }
            }
        }
        .font(.appBody)
    }
    
    private func toggleColor(for plan: PlanSubscribe) -> Color {
        switch plan {
        case .standard:
            return .accentColor
        case .premium:
            return .premium2
        }
    }
}

#Preview {
    ServicesTogglesView(plan: .standard, services: .constant(Subscribe.placeholder.services))
}
