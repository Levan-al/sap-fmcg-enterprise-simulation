# Segregation of Duties (SoD) Matrix

## Critical Conflicts Avoided

| Role Combination                          | Conflict Description                          | Why It Is Forbidden                  | Status |
|-------------------------------------------|-----------------------------------------------|--------------------------------------|--------|
| Z_MM_PURCH + Z_FI_AP                      | Create PO + Post Payment                      | High fraud risk                      | Avoided |
| Z_SD_SALES_ADV + Z_SD_BILLING             | Create Sales Order + Create Invoice           | Billing manipulation risk            | Avoided |
| Z_MM_INV_ADV + Z_FI_GL                    | Goods Receipt + FI Posting                    | Stock vs Financial mismatch risk     | Avoided |
| Z_MASTER + Any Transactional Role         | Master Data + Transactional changes           | Data integrity risk                  | Avoided |

## Implementation Method
- Roles created via PFCG with minimal overlapping authorizations
- Critical authorization objects restricted per role
- Periodic access review process recommended (SUIM)

This SoD design reflects real enterprise compliance requirements (e.g. SOX-like controls).
