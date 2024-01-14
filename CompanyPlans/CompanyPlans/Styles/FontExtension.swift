//
//  FontExtension.swift
//  CompanyPlans
//
//  Created by Denis Dmitriev on 13.01.2024.
//

import SwiftUI

extension Font {
    public static let appLargeTitle: Font = .system(.largeTitle, design: .rounded).weight(.semibold)
    public static let appHeader: Font = .system(size: AppGrid.pt28, weight: .medium, design: .rounded)
    public static let appTitle: Font =  .system(.title, design: .rounded).weight(.semibold)
    public static let appTitle2: Font =  .system(.title2, design: .rounded).weight(.semibold)
    public static let appTitle3: Font =  .system(.title3, design: .rounded).weight(.semibold)
    public static let appCaption: Font = .system(size: AppGrid.pt15, weight: .regular, design: .rounded)
    public static let appBody: Font =  .system(.body, design: .rounded).weight(.regular)
}
