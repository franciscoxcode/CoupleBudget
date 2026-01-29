//
//  Account.swift
//  CoupleBudgetCore
//
//  Created by Francisco Jean on 29/01/26.
//

import Foundation

public struct Account {
    public let id: UUID
    public var name: String
    public var isPlanifiable: Bool

    public init(id: UUID = UUID(), name: String, isPlanifiable: Bool) {
        self.id = id
        self.name = name
        self.isPlanifiable = isPlanifiable
    }
}

