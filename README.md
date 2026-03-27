# CoupleBudget

![Status](https://badgen.net/badge/status/in%20progress/yellow)
![Swift](https://badgen.net/badge/Swift/6.3/pink)
![UI](https://badgen.net/badge/UI/SwiftUI/blue)
![Architecture](https://badgen.net/badge/Architecture/MVVM/purple)
![Platform](https://badgen.net/badge/Platform/iOS/orange)

CoupleBudget simplifies shared money management by clearly separating three concepts that most finance apps mix together:

- **Accounts** — where real money lives (bank accounts, cash, cards)
- **Buckets** — budgets and savings goals unified in one concept
- **People** — personal loans without a complex loans system

---

## Screenshots

*Coming soon*

---

## Architecture

The project is split into two clear layers:

### CoupleBudgetCore (Swift Package)
Shared domain logic, completely independent from the UI.
```bash
CoupleBudgetCore
├── Models       — data structures (Account, Bucket, MoneyMovement)
├── Rules        — business logic validations
└── Calculators  — derived financial values (balances, totals)
```

### App Layer (iOS)
Built with SwiftUI following MVVM.
```bash
App
├── ViewModels   — prepare Core data for the UI
└── Views        — SwiftUI interface
```

The Core has no knowledge of the UI. The UI depends on the Core. Dependency flows in one direction only.

---

## Key Design Decisions

- **Models are passive** — structs that hold data only, no logic
- **Validation returns all errors at once** — better UX for forms, no interruptions from Swift's throws mechanism
- **Balances are computed values** — derived from movements, never stored directly
- **ID-based references** — models reference each other by UUID, avoiding duplication and inconsistencies

---

## Tests

The Core is fully unit tested with Swift Testing, covering all business logic independently from the UI.
```bash
CoupleBudgetCoreTests
├── Income validations
├── Expense validations
├── Transfer validations
├── Amount validations
└── Balance calculations
```

---

## Roadmap

- [x] Core domain models (Account, Bucket, Person, MoneyMovement)
- [x] Business logic validations (MoneyMovementRules)
- [x] Balance calculations (BalanceCalculator)
- [x] Unit tests for all Core logic
- [ ] Dashboard UI with real balances
- [ ] Create and manage accounts
- [ ] Record income, expenses and transfers
- [ ] Data persistence with SwiftData
- [ ] App Store release

---

## Getting Started

### Requirements
- Xcode 26 or newer
- iOS 18+ device or simulator

### Steps

1. Clone the repository:
```bash
git clone https://github.com/franciscoxcode/CoupleBudget.git
```

2. Open the project in Xcode:
```bash
open CoupleBudget/CoupleBudget.xcodeproj
```

3. Build and run on a simulator or real device.

---

## Contact

- [GitHub](https://github.com/franciscoxcode)
- [LinkedIn](https://www.linkedin.com/in/franciscoxcode/)
- [Email](mailto:fxcasillas.dev@gmail.com)

---

## License
Copyright (c) 2026 Francisco Javier Casillas Pérez. All rights reserved.
This project is proprietary and confidential. See [LICENSE](LICENSE) for details.

