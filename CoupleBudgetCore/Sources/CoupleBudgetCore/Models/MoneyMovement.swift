//
//  MoneyMovement.swift
//  CoupleBudgetCore
//
//  Created by Francisco Jean on 29/01/26.
//


import Foundation

public struct MoneyMovement {
    public enum `Type` {
        case income
        case expense
        case transfer
    }

    public let id: UUID
    public var date: Date
    public var amount: Decimal
    public var note: String?
    public var type: Type
    public var from: Entity?
    public var to: Entity?

    public init(
        id: UUID = UUID(),
        date: Date = Date(),
        amount: Decimal,
        note: String? = nil,
        type: Type,
        from: Entity? = nil,
        to: Entity? = nil
    ) {
        self.id = id
        self.date = date
        self.amount = amount
        self.note = note
        self.type = type
        self.from = from
        self.to = to
    }
}

