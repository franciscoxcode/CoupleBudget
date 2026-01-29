//
//  Person.swift
//  CoupleBudgetCore
//
//  Created by Francisco Jean on 29/01/26.
//

import Foundation
public struct Person {
    public let id: UUID
    public var name: String

    public init(id: UUID = UUID(), name: String) {
        self.id = id
        self.name = name
    }
}

