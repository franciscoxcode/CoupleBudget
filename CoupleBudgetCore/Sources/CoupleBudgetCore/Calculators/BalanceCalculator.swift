//
//  BalanceCalculator.swift
//  CoupleBudgetCore
//
//  Created by Francisco Jean on 27/03/26.
//

import Foundation

public struct BalanceCalculator {

    // Returns the current balance for a specific account
    // based on all money movements
    public static func balance(for account: Account, in movements: [MoneyMovement]) -> Decimal {
        var total: Decimal = 0

        for movement in movements {
            let isDestination = movement.to?.id == account.id
            let isSource = movement.from?.id == account.id

            if isDestination {
                total += movement.amount
            }
            if isSource {
                total -= movement.amount
            }
        }

        return total
    }

    // Returns the total balance of all planifiable accounts
    public static func totalPlanifiable(accounts: [Account], movements: [MoneyMovement]) -> Decimal {
        accounts
            .filter { $0.isPlanifiable }
            .reduce(Decimal(0)) { total, account in
                total + balance(for: account, in: movements)
            }
    }

    // Returns the total net worth across all accounts
    public static func totalNet(accounts: [Account], movements: [MoneyMovement]) -> Decimal {
        accounts.reduce(Decimal(0)) { total, account in
            total + balance(for: account, in: movements)
        }
    }
}
