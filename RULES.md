
# CoupleBudget — Core Rules (v2)

This document defines the core rules of the financial system.
UI, persistence, and sync are intentionally out of scope.

---

## Accounts

- An Account represents where money actually lives.
- Account balances are derived ONLY from money movements.
- Accounts can be **planifiable** or **non-planifiable**.
  - Planifiable accounts contribute to Unassigned.
  - Non-planifiable accounts (e.g. AFORE, long-term investments) do not.

---

## People

- A Person represents a real individual involved in money movements.
- A Person behaves like a logical account.
- A Person can have a positive or negative balance:
  - Positive → they owe you money
  - Negative → you owe them money
- People balances are derived ONLY from money movements.

---

## Buckets (Budgets & Savings)

- A Bucket represents an intention for money.
- Budgets and Savings are conceptually the same: both are Buckets.
- Buckets do NOT hold money themselves.
- Money is assigned to Buckets from Unassigned.
- Buckets can go negative.

---

## Unassigned

- Unassigned represents planifiable money that has not been assigned to any Bucket.
- Unassigned is calculated as:

  Planifiable account balances  
  − total assigned to Buckets

- Unassigned can be negative.
- Non-planifiable accounts never affect Unassigned.

---

## Money Movements

- A Money Movement represents a flow of money between two entities.
- Entities can be:
  - Account
  - Person

Movement types:
- Income
- Expense
- Transfer

Rules:
- Expense:
  - Always affects an Account.
  - MUST belong to a Bucket.
- Income:
    - Income represents money entering an Account.
    - Income always increases the balance of the destination Account.
    - If the destination Account is planifiable, the amount increases the planifiable total.
    
    Assignment rules:
    - Income MAY be assigned to a Bucket at creation time.
    - If Income is assigned to a Bucket:
        - the amount is allocated directly to that Bucket
        - it never becomes Unassigned
    - If Income is NOT assigned to a Bucket:
        - the amount increases Unassigned

    Note:
    - Assigned Income increases planifiable balances and bucket allocations by the same amount, so Unassigned remains unchanged.

- Transfer:
  - Moves money between two entities (Account ↔ Account, Account ↔ Person).
  - Does NOT affect Buckets.
  - Does NOT affect Unassigned directly.

---

## General Principles

- The system models reality through money flows, not labels.
- There is no special concept of “loan”.
- Debts emerge naturally from balances between Accounts and People.
- The system favors clarity over automation.
- The system reflects reality, even if values are negative.
- There is a single source of truth for all calculations.
