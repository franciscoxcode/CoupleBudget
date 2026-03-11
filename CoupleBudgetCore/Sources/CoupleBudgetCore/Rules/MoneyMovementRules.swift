//
//  MoneyMovementRules.swift
//  CoupleBudgetCore
//
//  Created by Francisco Jean on 11/03/26.
//

import Foundation

public enum ValidationError: Error {
    case missingDestination   // income without "to"
    case missingSource        // expense or transfer without "from"
    case missingBucket        // expense without bucketID
    case transferHasBucket    // transfer should not have a bucket
    case missingAmount        // amount must be > 0 
}

public func validate(_ movement: MoneyMovement) -> [ValidationError] {
    var errors: [ValidationError] = []

    if movement.amount <= 0 {
        errors.append(.missingAmount)
    }

    switch movement.type {
    case .income:
        if movement.to == nil {
            errors.append(.missingDestination)
        }

    case .expense:
        if movement.from == nil {
            errors.append(.missingSource)
        }
        if movement.bucketID == nil {
            errors.append(.missingBucket)
        }

    case .transfer:
        if movement.from == nil {
            errors.append(.missingSource)
        }
        if movement.to == nil {
            errors.append(.missingDestination)
        }
        if movement.bucketID != nil {
            errors.append(.transferHasBucket)
        }
    }

    return errors
}
