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
