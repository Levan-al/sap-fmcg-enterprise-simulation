# Qizi LLC — SAP End-to-End Implementation Plan

**Company:** შპს ქიზი (Qizi LLC)
**SAP Environment:** S/4HANA On-Premise
**Development Client:** 700
**Production Client:** 150
**Started:** April 2026
**Implemented by:** Levan Alughishvili
**GitHub:** https://github.com/Levan-al/sap-fmcg-enterprise-simulation

---

## გარემოს არქიტექტურა

```
Client 700 (Development + Testing)
         ↓
   STMS Transport Requests
         ↓
Client 150 (Production — Qizi LLC)
```

---

## PHASE 0 — System Setup & Security 🛡️
> Status: 🔄 In Progress

- [ ] **SCC4** → Client 150 შექმნა:
  ```
  Client   : 150
  Name     : Qizi LLC Production
  City     : Tbilisi
  Currency : GEL
  Role     : Production
  ```
- [ ] **SCCL** → Client Copy 000 → 150 (Profile: SAP_CUST)
- [ ] **SU01** → SAP* და DDIC პაროლების შეცვლა
- [ ] **SU01** → Admin იუზერის შექმნა: `QIZI_ADMIN`
- [ ] **SU01** → SAP_ALL მხოლოდ `QIZI_ADMIN`-ზე; ყველა სხვა იუზერი — Lock
- [ ] **RZ10** → SAP* ავტომატური Login გათიშვა:
  ```
  login/no_automatic_user_sapstar : 1
  ```
- [ ] **SCC4** → Client Protection:
  ```
  Changes and Transports : No changes allowed
  Protection Level       : 2
  ```
- [ ] **RZ10** → პაროლის პოლიტიკა:
  ```
  login/max_failed_attempts     : 5
  login/min_password_length     : 10
  login/password_expiration     : 90
  login/password_change_waittime: 1
  ```
- [ ] **STMS** → Transport Domain კონფიგურაცია
- [ ] **STMS** → Transport Route: `700 (DEV) → 150 (PRD)`
- [ ] **STMS** → Transport Layer: `ZQIZI`
- [ ] **SM59** → შიდა RFC კავშირი 700 ↔ 150
- [ ] **SM59** → გარე RFC კავშირების გათიშვა Client 150-ზე
- [ ] **SM19/SM20** → Security Audit Log გააქტიურება:
  ```
  Failed Login Attempts → Log + Alert
  Successful Logins     → Log
  Authorization Errors  → Log + Alert
  Transaction Starts    → Log
  ```
- [ ] Inactive User Policy: 90 დღე → ავტომატური Lock
- [ ] **SM50** → Process Monitoring
- [ ] **DB02** → Database სივრცის შემოწმება

> ⚠️ **შენიშვნა:** SAP_ALL-ის წაშლა + უცხო იუზერების Lock +
> SAP* Login-ის გათიშვა = Client 150 პრაქტიკულად იზოლირებული გარემო.
> OS/Basis დონის წვდომა მაინც შესაძლებელია IT ადმინისთვის —
> ეს SAP-ის არქიტექტურული შეზღუდვაა.

---

## PHASE 1 — Enterprise Structure & Master Data 🏗️
> Status: 🔄 In Progress (Client 700-ში → Transport → Client 150)

### 1.1 Organizational Structure

- [x] **OX02** → Company Code `QIZI` *(გაკეთებულია Client 700-ში)*
- [x] **OBBG/OBYZ** → Tax Procedure `TAXGEO` → GE *(გაკეთებულია)*
- [x] **SPRO** → Region `TB` → Tbilisi *(გაკეთებულია)*
- [x] **OX10** → Plants: `QZ01`, `QZ02`, `QZ03` *(გაკეთებულია)*
- [x] **OX18** → Plant → Company Code Assignment *(გაკეთებულია)*
- [ ] **OX09** → Storage Locations:
  ```
  QZ01: HL01 — Hazelnut Raw Material
        HL02 — Hazelnut Processed
  QZ02: WN01 — Wine Storage
  QZ03: DC01 — Distribution Stock
        DC02 — Returns
  ```
- [ ] **OVX5** → Sales Organization `QZ01`
- [ ] **OVXI** → Distribution Channels:
  ```
  10 — Modern Trade (Carrefour, Goodwill, Nikora...)
  20 — Wholesale / Export
  30 — Direct Sales
  ```
- [ ] **OVXB** → Divisions:
  ```
  10 — Hazelnut
  20 — Wine
  30 — FMCG Distribution
  ```
- [ ] **OVXG** → Sales Area Assignments
- [ ] **OVX3** → Sales Org → Company Code
- [ ] **SPRO** → Warehouse Number `QZ1`

### 1.2 Master Data

- [ ] **MM01** → Material Master:
  ```
  HZLNT-RAW  — Hazelnut Raw (კგ)
  HZLNT-PROC — Hazelnut Processed (კგ)
  WINE-750   — Wine Bottle 750ml (ბოთლი)
  FMCG-GEN   — Generic FMCG (ც)
  ```
- [ ] **XK01 / BP** → Vendor Master
- [ ] **XD01 / BP** → Customer Master:
  ```
  CARREFOUR — Carrefour Georgia
  GOODWILL  — Goodwill
  AGROHUB   — Agrohub
  NIKORA    — Nikora
  ```
- [ ] **ME11** → Purchase Info Records
- [ ] **ME01** → Source Lists

### 1.3 Authorization (Phase 1B)

- [ ] **PFCG** → Roles შექმნა (Least Privilege):
  ```
  Z_QIZI_ADMIN   — სრული Admin (1 იუზერი)
  Z_QIZI_FI      — Finance
  Z_QIZI_MM      — Procurement
  Z_QIZI_SD      — Sales
  Z_QIZI_WM      — Warehouse
  Z_QIZI_PP      — Production
  Z_QIZI_CO      — Controlling
  Z_QIZI_AP      — AP Clerk
  Z_QIZI_AR      — AR Clerk
  Z_QIZI_WH      — Warehouse Operator
  Z_QIZI_DISPLAY — Read-Only
  Z_QIZI_AUDIT   — Auditor (Read-Only)
  ```
- [ ] Authorization Objects:
  ```
  F_BKPF_BUK → QIZI
  M_MSEG_WMB → QZ01, QZ02, QZ03
  V_VBAK_VKO → QZ01
  S_TABU_DIS → სენსიტიური ცხრილები
  ```

---

## PHASE 2 — Financial Accounting Core (FI) 💰
> Status: ⬜ Planned

- [ ] **OB13** → Chart of Accounts `QIZI`
- [ ] **OBD4** → Account Groups
- [ ] **FS00** → GL Accounts:
  ```
  1000000 — Fixed Assets
  1100000 — Cash / Bank
  1200000 — Accounts Receivable
  2000000 — Accounts Payable
  3000000 — Revenue
  4000000 — Cost of Goods Sold
  5000000 — Operating Expenses
  ```
- [ ] **OB29** → Fiscal Year Variant (Jan–Dec)
- [ ] **OB52** → Posting Periods
- [ ] **FI12** → House Bank:
  ```
  TBC — თიბისი ბანკი
  BOG — საქართველოს ბანკი
  ```
- [ ] **FBZP** → Payment Methods (GEL, USD)
- [ ] **OBBG/OBYZ** → Tax Configuration `TAXGEO` (VAT 18%)
- [ ] Accounts Payable Setup
- [ ] Accounts Receivable Setup
- [ ] **AS01** → Asset Master:
  ```
  LAND-001  — 15ha თხილის ბაღი
  BUILD-001 — ღვინის სარდაფი
  MACH-001  — ტრაქტორი
  MACH-002  — დამუშავების ტექნიკა
  ```
- [ ] **AFAB** → Depreciation Run Setup

---

## PHASE 3 — Materials Management (MM) + Procurement 📦
> Status: ⬜ Planned

- [ ] **MM01/MM02** → Material Master refinement
- [ ] Procurement Cycle:
  - [ ] **ME51N** → Purchase Requisition (PR)
  - [ ] **ME21N** → Purchase Order (PO)
  - [ ] **MIGO** → Goods Receipt (GR)
  - [ ] **MIRO** → Invoice Verification
  - [ ] **F110** → Automatic Payment
- [ ] **MMBE / MB52** → Inventory Management
- [ ] **SE38** → Deploy & Test:
  - [ ] `Z_STOCK_VISIBILITY`
  - [ ] `Z_MOVEMENT_CONTROL`

---

## PHASE 4 — Warehouse Management (WM) & Automation 🏭
> Status: ⬜ Planned
> *(GitHub repo-ს ძირითადი ნაწილი)*

- [ ] **SPRO** → Warehouse Structure:
  ```
  Warehouse Number : QZ1
  Storage Types    : Raw, Processed, Finished
  Storage Sections : Hazelnut, Wine, FMCG
  ```
- [ ] **LT01** → Transfer Orders
- [ ] **MB1B** → Stock Transfers
- [ ] **SE38** → 7 Z-Reports სრული Deployment (GitHub-დან):
  - [ ] `Z_STOCK_VISIBILITY`
  - [ ] `Z_MOVEMENT_CONTROL`
  - [ ] `Z_AUTO_TRANSFERS` *(BAPI_GOODSMVT_CREATE)*
  - [ ] `Z_WAREHOUSE_ANALYTICS`
  - [ ] `Z_ERROR_DETECTION`
  - [ ] `Z_MM_FI_SYNC`
  - [ ] `Z_DELIVERY_CONTROL`
- [ ] **STMS** → Z-Reports Transport: `700 → 150`

---

## PHASE 5 — Sales & Distribution (SD) 🛒
> Status: ⬜ Planned

- [ ] Sales Organization, Distribution Channel, Division კონფიგურაცია
- [ ] **XD01/BP** → Customer Master
- [ ] **VK11** → Pricing Conditions
- [ ] Sales Cycle:
  - [ ] **VA01** → Sales Order
  - [ ] **VL01N** → Outbound Delivery
  - [ ] **VL02N** → Post Goods Issue (PGI)
  - [ ] **VF01** → Billing
  - [ ] **F-28** → Payment Receipt
- [ ] SD ↔ WM Integration

---

## PHASE 6 — Production Planning (PP) 🌱
> Status: ⬜ Planned

### 🌰 Hazelnut Production
- [ ] **CS01** → BOM
- [ ] **CR01** → Work Centers (Farm, Processing)
- [ ] **CA01** → Routing
- [ ] **CO01** → Production Orders

### 🍷 Wine Production
- [ ] **CS01** → BOM (Grape → Wine → Bottle)
- [ ] **CR01** → Work Centers (Winery)
- [ ] **CO01** → Production Orders

---

## PHASE 7 — Controlling (CO) & Integration 🔧
> Status: ⬜ Planned

- [ ] **OKKP** → Controlling Area
- [ ] **KS01** → Cost Centers:
  ```
  FARM  — Hazelnut Farm
  WINE  — Winery
  DIST  — Distribution Center
  ADMIN — Administration
  ```
- [ ] **KA01** → Cost Elements
- [ ] **KE51** → Profit Centers:
  ```
  PC-HZL — Hazelnut
  PC-WIN — Wine
  PC-FMC — FMCG Distribution
  ```
- [ ] **KO01** → Internal Orders
- [ ] MM ↔ FI Integration
- [ ] SD ↔ FI Revenue Recognition
- [ ] PP ↔ CO Cost Allocation
- [ ] **Z_MM_FI_SYNC** → Reconciliation
- [ ] **KSB1** → Cost Center Reports
- [ ] **KE30** → Profitability Analysis

---

## PHASE 8 — Users, Roles & Security 🔐
> Status: ⬜ Planned

- [ ] **SU01/SU10** → 11 Users შექმნა:
  ```
  QIZI_ADMIN — System Administrator
  QIZI_FI    — Finance Manager
  QIZI_MM    — Procurement Manager
  QIZI_WM    — Warehouse Manager
  QIZI_SD    — Sales Manager
  QIZI_PP    — Production Manager
  QIZI_CO    — Controlling
  QIZI_AP    — Accounts Payable Clerk
  QIZI_AR    — Accounts Receivable Clerk
  QIZI_WH1   — Warehouse Operator 1
  QIZI_WH2   — Warehouse Operator 2
  QIZI_AUDIT — Read-Only Auditor
  ```
- [ ] **PFCG** → 11 Roles (Least Privilege)
- [ ] Segregation of Duties (SoD) Matrix
- [ ] **SU53** → Authorization Testing
- [ ] **SUIM** → User & Auth. Reporting

---

## PHASE 9 — RAP & Modernization 🚀
> Status: ⬜ In Progress *(GitHub-ში უკვე არის ნაწილი)*

- [ ] CDS Views:
  - [ ] `Z_I_WAREHOUSE_STOCK`
  - [ ] `Z_I_WAREHOUSE_KPI`
- [ ] RAP Behavior Definitions + Actions
- [ ] OData Services (Service Definition + Binding)
- [ ] Fiori Elements Applications *(optional)*

---

## System Administration (მუდმივი) ⚙️

| სამუშაო | T-Code | სიხშირე |
|---------|--------|---------|
| Process Monitoring | SM50 | ყოველდღე |
| Security Audit | SM20 | კვირაში |
| System Log | SM21 | კვირაში |
| Database მონიტორინგი | DB02 | კვირაში |
| Inactive Users | SU01 | თვეში |
| RFC შემოწმება | SM59 | თვეში |
| Transport მართვა | STMS | საჭიროებისამებრ |
| Performance Tuning | RZ10 | საჭიროებისამებრ |

---

## Progress Overview

| Phase | Topic | Client | Status |
|-------|-------|--------|--------|
| 0 | System Setup & Security | 700/150 | 🔄 In Progress |
| 1 | Enterprise Structure & Master Data | 700→150 | 🔄 In Progress |
| 2 | Financial Accounting (FI) | 700→150 | ⬜ Planned |
| 3 | MM + Procurement | 700→150 | ⬜ Planned |
| 4 | WM + Z-Reports | 700→150 | ⬜ Planned |
| 5 | Sales & Distribution (SD) | 700→150 | ⬜ Planned |
| 6 | Production Planning (PP) | 700→150 | ⬜ Planned |
| 7 | Controlling (CO) + Integration | 700→150 | ⬜ Planned |
| 8 | Users & Security | 150 | ⬜ Planned |
| 9 | RAP & Modernization | 700→150 | ⬜ In Progress |
| ∞ | System Administration | 150 | 🔄 Ongoing |
