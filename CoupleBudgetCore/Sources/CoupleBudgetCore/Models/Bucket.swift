//
//  Bucket.swift
//  CoupleBudgetCore
//
//  Created by Francisco Jean on 29/01/26.
//

import Foundation

public struct Bucket {
    public enum Kind {
        case budget
        case saving
    }

    public let id: UUID
    public var name: String
    public var kind: Kind
    public var emoji: String?

    public init(
        id: UUID = UUID(),
        name: String,
        kind: Kind,
        emoji: String? = nil
    ) {
        self.id = id
        self.name = name
        self.kind = kind
        self.emoji = emoji
    }
}

