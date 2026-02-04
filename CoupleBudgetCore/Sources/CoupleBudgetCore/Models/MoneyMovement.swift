//
//  MoneyMovement.swift
//  CoupleBudgetCore
//
//  Created by Francisco Jean on 29/01/26.
//


import Foundation

public struct MoneyMovement {
    public enum MovementType {
        case income
        case expense
        case transfer
    }

    public let id: UUID
    public var date: Date
    public var amount: Decimal
    public var note: String?
    public var type: MovementType
    public var from: Entity?
    public var to: Entity?
    public var bucketID: UUID?

    public init(
        id: UUID = UUID(),
        date: Date = Date(),
        amount: Decimal,
        note: String? = nil,
        type: MovementType,
        from: Entity? = nil,
        to: Entity? = nil,
        bucketID: UUID? = nil
    ) {
        self.id = id
        self.date = date
        self.amount = amount
        self.note = note
        self.type = type
        self.from = from
        self.to = to
        self.bucketID = bucketID
    }
}

