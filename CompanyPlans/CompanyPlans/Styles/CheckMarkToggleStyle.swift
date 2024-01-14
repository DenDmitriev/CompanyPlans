//
//  CheckMarkToggleStyle.swift
//  CompanyPlans
//
//  Created by Denis Dmitriev on 13.01.2024.
//

import SwiftUI

struct CheckMarkToggleStyle: ToggleStyle {
    
    @Environment(\.isEnabled) private var isEnabled: Bool
    let color: Color
    
    func makeBody(configuration: Configuration) -> some View {
        Button {
            configuration.isOn.toggle()
        } label: {
            Label {
                let color: Color = {
                    if isEnabled {
                        Color.primary
                    } else {
                        configuration.isOn ? Color.primary : .destructive
                    }
                }()
                configuration.label
                    .foregroundStyle(color)
                    .strikethrough(!isEnabled, color: .destructive)
            } icon: {
                let systemName: String = {
                    if isEnabled {
                        configuration.isOn ? "checkmark.circle.fill" : "circle"
                    } else {
                        "xmark.circle.fill"
                    }
                }()
                Image(systemName: systemName)
                    .fontWeight(.bold)
                    .foregroundStyle(configuration.isOn ? color : .destructive)
                    .accessibility(label: Text(configuration.isOn ? "Checked" : "Unchecked"))
                    .imageScale(.large)
            }
            .labelStyle(.alignment(.center))
        }
    }
}

extension ToggleStyle where Self == CheckMarkToggleStyle {
    static func checkMark(color: Color = .accentColor) -> CheckMarkToggleStyle { .init(color: color) }
}

#Preview  {
    struct PreviewWrapper: View {
        @State var isOn: Bool = true
        
        var body: some View {
            VStack {
                Toggle(isOn: $isOn, label: {
                    Text("Label")
                })
                .toggleStyle(.checkMark())
                
                Toggle(isOn: .constant(false), label: {
                    Text("Label")
                })
                .toggleStyle(.checkMark())
                
                Toggle(isOn: .constant(false), label: {
                    Text("Label")
                })
                .toggleStyle(.checkMark())
                .disabled(true)
            }
        }
    }
    
    return PreviewWrapper()
}
