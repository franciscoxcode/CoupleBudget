# CoupleBudget

A personal finance app for couples, built with Swift and SwiftUI.

CoupleBudget simplifies shared money management by clearly separating three concepts that most finance apps mix together:

- **Accounts** — where real money lives (bank accounts, cash, cards)
- **Budgets**  — budgets and savings goals (intentions for money)
- **People**  — personal loans without a complex loans system

---

## Architecture

The project is split into two clear layers:

### CoupleBudgetCore (Swift Package)
Shared domain logic, completely independent from the UI.
```
CoupleBudgetCore
├── Models       — data structures (Account, Bucket, MoneyMovement)
├── Rules        — business logic validations
└── Calculators  — derived financial values (balances, totals)
```

### App Layer (iOS)
Built with SwiftUI following MVVM.
```
App
├── ViewModels   — prepare Core data for the UI
└── Views        — SwiftUI interface
```

The Core has no knowledge of the UI. The UI depends on the Core. Dependency flows in one direction only.

---

## Key Design Decisions

- **Models are passive** — structs that hold data only, no logic
- **Validation returns all errors at once** — better UX for forms, no try/catch interruptions
- **Balances are computed values** — derived from movements, never stored directly
- **ID-based references** — models reference each other by UUID, avoiding duplication and inconsistencies

---

## Tests

The Core is fully unit tested with Swift Testing.
```
CoupleBudgetCoreTests
├── Income validations
├── Expense validations
├── Transfer validations
└── Amount validations
```

---

## Tech Stack

- Swift 6
- SwiftUI
- Swift Package Manager
- Swift Testing

---

## Status

🚧 In active development