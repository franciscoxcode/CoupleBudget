import Testing
import Foundation
@testable import CoupleBudgetCore

// MARK: - Income tests
@Test func income_valid() {
    let account = Entity(name: "Banco", kind: .account)
    let movement = MoneyMovement(
        amount: 100,
        type: .income,
        to: account
    )
    #expect(validate(movement).isEmpty)
}

@Test func income_missing_destination() {
    let movement = MoneyMovement(
        amount: 100,
        type: .income
    )
    #expect(validate(movement).contains(.missingDestination))
}

// MARK: - Expense tests
@Test func expense_valid() {
    let account = Entity(name: "Banco", kind: .account)
    let movement = MoneyMovement(
        amount: 50,
        type: .expense,
        from: account,
        bucketID: UUID()
    )
    #expect(validate(movement).isEmpty)
}

@Test func expense_missing_source() {
    let movement = MoneyMovement(
        amount: 50,
        type: .expense,
        bucketID: UUID()
    )
    #expect(validate(movement).contains(.missingSource))
}

@Test func expense_missing_bucket() {
    let account = Entity(name: "Banco", kind: .account)
    let movement = MoneyMovement(
        amount: 50,
        type: .expense,
        from: account
    )
    #expect(validate(movement).contains(.missingBucket))
}

// MARK: - Transfer tests
@Test func transfer_valid() {
    let checking = Entity(name: "Checking", kind: .account)
    let savings = Entity(name: "Savings", kind: .account)
    let movement = MoneyMovement(
        amount: 200,
        type: .transfer,
        from: checking,
        to: savings
    )
    #expect(validate(movement).isEmpty)
}

@Test func transfer_missing_source() {
    let savings = Entity(name: "Savings", kind: .account)
    let movement = MoneyMovement(
        amount: 200,
        type: .transfer,
        to: savings
    )
    #expect(validate(movement).contains(.missingSource))
}

@Test func transfer_should_not_have_bucket() {
    let checking = Entity(name: "Checking", kind: .account)
    let savings = Entity(name: "Savings", kind: .account)
    let movement = MoneyMovement(
        amount: 200,
        type: .transfer,
        from: checking,
        to: savings,
        bucketID: UUID()
    )
    #expect(validate(movement).contains(.transferHasBucket))
}

// MARK: - Amount tests
@Test func movement_amount_must_be_positive() {
    let account = Entity(name: "Banco", kind: .account)
    let movement = MoneyMovement(
        amount: 0,
        type: .income,
        to: account
    )
    #expect(validate(movement).contains(.missingAmount))
}

// MARK: - BalanceCalculator tests

@Test func balance_income_adds_to_account() {
    let bank = Account(name: "Bank", isPlanifiable: true)
    let bankEntity = Entity(id: bank.id, name: bank.name, kind: .account)
    
    let movement = MoneyMovement(
        amount: 100,
        type: .income,
        to: bankEntity
    )
    
    let result = BalanceCalculator.balance(for: bank, in: [movement])
    #expect(result == 100)
}

@Test func balance_expense_subtracts_from_account() {
    let bank = Account(name: "Bank", isPlanifiable: true)
    let bankEntity = Entity(id: bank.id, name: bank.name, kind: .account)
    
    let movement = MoneyMovement(
        amount: 50,
        type: .expense,
        from: bankEntity,
        bucketID: UUID()
    )
    
    let result = BalanceCalculator.balance(for: bank, in: [movement])
    #expect(result == -50)
}

@Test func balance_transfer_moves_between_accounts() {
    let checking = Account(name: "Checking", isPlanifiable: true)
    let savings = Account(name: "Savings", isPlanifiable: true)
    let checkingEntity = Entity(id: checking.id, name: checking.name, kind: .account)
    let savingsEntity = Entity(id: savings.id, name: savings.name, kind: .account)
    
    let movement = MoneyMovement(
        amount: 200,
        type: .transfer,
        from: checkingEntity,
        to: savingsEntity
    )
    
    #expect(BalanceCalculator.balance(for: checking, in: [movement]) == -200)
    #expect(BalanceCalculator.balance(for: savings, in: [movement]) == 200)
}

@Test func total_planifiable_excludes_non_planifiable() {
    let bank = Account(name: "Bank", isPlanifiable: true)
    let retirement = Account(name: "Retirement", isPlanifiable: false)
    let bankEntity = Entity(id: bank.id, name: bank.name, kind: .account)
    let retirementEntity = Entity(id: retirement.id, name: retirement.name, kind: .account)
    
    let movements = [
        MoneyMovement(amount: 1000, type: .income, to: bankEntity),
        MoneyMovement(amount: 5000, type: .income, to: retirementEntity)
    ]
    
    let result = BalanceCalculator.totalPlanifiable(
        accounts: [bank, retirement],
        movements: movements
    )
    #expect(result == 1000)
}

@Test func total_net_includes_all_accounts() {
    let bank = Account(name: "Bank", isPlanifiable: true)
    let retirement = Account(name: "Retirement", isPlanifiable: false)
    let bankEntity = Entity(id: bank.id, name: bank.name, kind: .account)
    let retirementEntity = Entity(id: retirement.id, name: retirement.name, kind: .account)
    
    let movements = [
        MoneyMovement(amount: 1000, type: .income, to: bankEntity),
        MoneyMovement(amount: 5000, type: .income, to: retirementEntity)
    ]
    
    let result = BalanceCalculator.totalNet(
        accounts: [bank, retirement],
        movements: movements
    )
    #expect(result == 6000)
}
