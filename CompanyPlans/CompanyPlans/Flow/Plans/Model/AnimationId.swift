//
//  AnimationId.swift
//  CompanyPlans
//
//  Created by Denis Dmitriev on 14.01.2024.
//

import Foundation

final class AnimationId {
    static func image(_ id: String) -> String { "\(id) image" }
    static func title(_ id: String) -> String { "\(id) title" }
    static func price(_ id: String) -> String { "\(id) price" }
    static func button(_ id: String) -> String { "\(id) button" }
    static func toggles(_ id: String) -> String { "\(id) toggles" }
    static func comment(_ id: String) -> String { "\(id) comment" }
    static func backgroundShape(_ id: String) -> String { "\(id) backgroundShape" }
    static func header(_ id: String) -> String { "\(id) header" }
}
