//
//  AppButtonStyle.swift
//  CompanyPlans
//
//  Created by Denis Dmitriev on 13.01.2024.
//

import SwiftUI

public struct FilledButtonStyle : PrimitiveButtonStyle {
    
    let color: Color

    public func makeBody(configuration: Configuration) -> some View {
        Button(action: {
            configuration.trigger()
        }, label: {
            ZStack {
                RoundedRectangle(cornerRadius: 16.0)
                    .fill(color)
                    .frame(maxWidth: .infinity)
                    .frame(height: AppGrid.pt56)
                
                
                configuration.label
                    .foregroundStyle(.white)
                    .font(.appBody)
                    .fontWeight(.medium)
            }
        })
        
    }
}

extension PrimitiveButtonStyle where Self == FilledButtonStyle {
    static func fill(color: Color = .accentColor) -> FilledButtonStyle { .init(color: color) }
}

#Preview {
    Button("Start") {
        print("Taped")
    }
    .buttonStyle(.fill())
}
