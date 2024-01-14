//
//  AlignmentLabelStyle.swift
//  CompanyPlans
//
//  Created by Denis Dmitriev on 13.01.2024.
//

import SwiftUI

struct AlignmentLabelStyle: LabelStyle {
    var alignment: VerticalAlignment
    
    func makeBody(configuration: Configuration) -> some View {
        HStack(alignment: alignment) {
            configuration.icon
            configuration.title.multilineTextAlignment(.leading)
        }
    }
}

extension LabelStyle where Self == AlignmentLabelStyle {

    static func alignment(_ alignment: VerticalAlignment) -> AlignmentLabelStyle { .init(alignment: alignment) }
}
