# 08 - Design Decisions & Trade-offs

This section summarizes key design decisions made during the project.

## Major Design Decisions

### 1. Modular Z-Report Structure (TOP/SEL/MAIN)
**Why?**  
- Better readability and maintainability  
- Easier debugging and testing  
- Consistent coding style across all 7 reports

### 2. Use of BAPI instead of direct UPDATE
**Why?**  
- Standard SAP posting logic  
- Better error handling and rollback capability  
- Future-proof (works with S/4HANA)

### 3. CDS Views for Analytics
**Why?**  
- Modern SAP approach  
- Better performance for reporting  
- Preparation for Fiori / Embedded Analytics

### 4. Role-Based Access + SoD
**Why?**  
- Realistic enterprise security model  
- Prevents fraud and errors  
- Shows understanding of authorization concepts

## Trade-offs

| Aspect                  | Chosen Approach               | Alternative                  | Reason Chosen                  |
|-------------------------|-------------------------------|------------------------------|--------------------------------|
| ALV vs Fiori            | Classical ALV                 | Fiori Elements               | Faster implementation in training env |
| BAPI vs Direct Update   | BAPI_GOODSMVT_CREATE          | Direct table update          | Safety and standard compliance |
| Logging                 | SLG1 + messages               | Custom Z-table               | Standard tool, easy to maintain |
| Testing Environment     | Client 500                    | Real production-like client  | Training / safety              |

## Lessons Learned
- Process thinking is more important than individual transactions
- Clean modular code makes future enhancements much easier
- Documentation and diagrams help senior reviewers understand the big picture quickly
