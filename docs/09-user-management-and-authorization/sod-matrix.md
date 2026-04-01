# Segregation of Duties (SoD) Matrix

This matrix shows the critical Segregation of Duties rules implemented in the project to prevent fraud, errors, and conflicts of interest.

## Critical SoD Rules

| # | Role Combination                          | Conflict Description                                      | Risk Level | Status    |
|---|-------------------------------------------|-----------------------------------------------------------|------------|-----------|
| 1 | Z_MM_PURCH + Z_FI_AP                      | Create Purchase Order + Post Vendor Payment               | High       | Avoided   |
| 2 | Z_SD_SALES_ADV + Z_SD_BILLING             | Create Sales Order + Create Customer Invoice              | High       | Avoided   |
| 3 | Z_MM_INV_ADV + Z_FI_GL                    | Goods Receipt + FI Accounting Posting                     | High       | Avoided   |
| 4 | Z_MASTER + Any Transactional Role         | Master Data Maintenance + Transactional Posting           | High       | Avoided   |
| 5 | Z_MM_PURCH + Z_LOGISTICS                  | Create PO + Confirm Delivery                              | Medium     | Avoided   |
| 6 | Z_SD_SALES_ADV + Z_FI_AR                  | Create Sales Order + Post Customer Payment                | Medium     | Avoided   |

## Implementation Details

- **Roles** were designed in PFCG with minimal overlapping authorizations
- **Critical authorization objects** (M_MATE_WRK, M_MATE_LGO, F_BKPF_BUK, etc.) are restricted per role
- **No user** has conflicting combination of create + post rights in sensitive processes
- **SU53** is used for access issue troubleshooting
- **SUIM** is recommended for periodic access review

## Why SoD Matters

In real enterprise environments, weak SoD can lead to:
- Financial fraud
- Data manipulation
- Compliance violations (SOX, internal audit, etc.)

This project demonstrates awareness of enterprise-grade security and compliance principles.

## Recommendation for Production
- Implement automated SoD conflict detection tools
- Define approval workflows for critical transactions
- Regular access review every 3–6 months
