# Qizi LLC — SAP End-to-End Implementation Plan

**Company:** შპს ქიზი (Qizi LLC)
**SAP Environment:** S/4HANA On-Premise (EPAM Training — System E86)
**Development Client:** 700
**QAS Client:** 800 (მომავალში)
**Production Client:** 150
**Started:** April 2026
**Implemented by:** Levan Alughishvili
**GitHub:** https://github.com/Levan-al/sap-fmcg-enterprise-simulation

---

## გარემოს არქიტექტურა

```
Client 700 (DEV — Development + Testing)
         ↓ STMS Transport Requests
Client 800 (QAS — User Acceptance Testing) ← მომავალში
         ↓ STMS Transport Requests
Client 150 (PRD — Production, Qizi LLC)
```

> ⚠️ **Client Strategy:** DEV → PRD პირდაპირი Transport მხოლოდ
> დროებითია. სრული Production-ready სისტემისთვის QAS (800) საჭიროა.

---

## PHASE 0 — System Setup & Security 🛡️
> Status: 🔄 In Progress

### დასრულებული ✅
- [x] **SCC4** → Client 150 შექმნა
- [x] **SM59** → RFC Destination `E86CLNT150` + Connection Test ✅
- [x] **SE38** → `ZCREATE_USER_150` პროგრამა შექმნა ✅
- [x] **OBBG/OBYZ** → Tax Procedure `TAXGEO` (Client 700)
- [x] **SPRO** → Region `TB` → Tbilisi (Client 700)

### დარჩენილი ⬜
- [ ] **Client 150-ში შესვლა** ← ⚠️ მთავარი დაბლოკვა!
  > **გამოსავალი:** Alaksei Mironchyk-ს სთხოვე:
  > *"SCCL გაუშვა: Source 000 → Target 150, Profile: SAP_UONL"*
- [ ] **SCCL** → Client Copy 000 → 150 (Profile: SAP_CUST)
- [ ] **SU01** → SAP* და DDIC პაროლების შეცვლა
- [ ] **SU01** → `QIZI_ADMIN` შექმნა (SAP_NEW პროფილით, არა SAP_ALL!)
- [ ] **SU01** → ყველა სხვა იუზერი → Lock
- [ ] **SUIM** → SAP_ALL-ის პირდაპირი მინიჭება წაშლა ყველა იუზერიდან
- [ ] **RZ10** → SAP* გათიშვა:
  ```
  login/no_automatic_user_sapstar : 1
  ```
- [ ] **SCC4** → Client 150 Protection:
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
- [ ] **SM59** → გარე RFC კავშირების გათიშვა Client 150-ზე
- [ ] **SM19/SM20** → Security Audit Log:
  ```
  Failed Login    → Log + Alert
  Successful Login→ Log
  Auth. Errors    → Log + Alert
  Transaction     → Log
  ```
- [ ] Inactive User Policy: 90 დღე → Lock
- [ ] **SM50** → Process Monitoring
- [ ] **DB02** → Database შემოწმება

---

## PHASE 1 — Enterprise Structure & Master Data 🏗️
> Status: 🔄 In Progress (Client 700-ში)

### დასრულებული ✅
- [x] **OX02** → Company Code `QIZI`
- [x] **OBBG/OBYZ** → Tax Procedure `TAXGEO`
- [x] **SPRO** → Region `TB` → Tbilisi
- [x] **OX10** → Plants: `QZ01`, `QZ02`, `QZ03`
- [x] **OX18** → Plant → Company Code Assignment

### 1.1 Organizational Structure ⬜
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

### 1.2 Master Data ⬜
- [ ] **MM01** → Material Master:
  ```
  HZLNT-RAW  — Hazelnut Raw (კგ)
  HZLNT-PROC — Hazelnut Processed (კგ)
  WINE-750   — Wine Bottle 750ml (ბოთლი)
  FMCG-GEN   — Generic FMCG (ც)
  ```
- [ ] **BP** → Business Partner (S/4HANA სტანდარტი!):
  ```
  Carrefour → Customer Role
  Goodwill  → Customer Role
  Agrohub   → Vendor Role
  Nikora    → Customer Role
  ```
  > ⚠️ S/4HANA-ში BP არის ცენტრალური.
  > XD01/XK01 მხოლოდ CVI-ის შემდეგ backward compatibility-ისთვის.
- [ ] **ME11** → Purchase Info Records
- [ ] **ME01** → Source Lists

### 1.3 Authorization ⬜
- [ ] **PFCG** → 12 Roles (Least Privilege):
  ```
  Z_QIZI_ADMIN   — Admin (1 იუზერი, SAP_NEW-ზე დაფუძნებული)
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
  Z_QIZI_AUDIT   — Auditor
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
- [ ] **FI12** → House Bank: TBC + BOG
- [ ] **FBZP** → Payment Methods (GEL, USD)
- [ ] Tax Codes (VAT 18%)
- [ ] AP / AR Setup
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
- [ ] **MMBE/MB52** → Inventory Management
- [ ] **SE38** → Deploy & Test:
  - [ ] `Z_STOCK_VISIBILITY`
  - [ ] `Z_MOVEMENT_CONTROL`

---

## PHASE 4 — Warehouse Management & Automation 🏭
> Status: ⬜ Planned

> ⚠️ **არქიტექტურული გადაწყვეტილება:**
> S/4HANA-ში ორი ვარიანტია:
> - **LE-WM** — მარტივი, მაგრამ deprecated new projects-ისთვის
> - **Embedded EWM** — recommended, მაგრამ ლიცენზია საჭიროა
>
> **შემდეგი ნაბიჯი:** EPAM-ის სისტემაში შევამოწმოთ EWM აქტიურია თუ არა.
> თუ აქტიურია → EWM. თუ არა → LE-WM (training მიზნებისთვის მისაღებია).

### Embedded EWM (თუ ხელმისაწვდომია):
- [ ] `/SCWM/SCDU` → Warehouse Number `QZ1`
- [ ] `/SCWM/SL` → Storage Types
- [ ] `/SCWM/ST` → Storage Sections
- [ ] `/SCWM/TO_CREATE` → Transfer Orders

### Z-Reports Deployment (FI/MM Integration):
- [ ] **SE38** → 7 Z-Reports:
  - [ ] `Z_STOCK_VISIBILITY`
  - [ ] `Z_MOVEMENT_CONTROL`
  - [ ] `Z_AUTO_TRANSFERS` (BAPI_GOODSMVT_CREATE)
  - [ ] `Z_WAREHOUSE_ANALYTICS`
  - [ ] `Z_ERROR_DETECTION`
  - [ ] `Z_MM_FI_SYNC`
  - [ ] `Z_DELIVERY_CONTROL`
- [ ] **STMS** → Transport: `700 → 150`

---

## PHASE 5 — Sales & Distribution (SD) 🛒
> Status: ⬜ Planned

- [ ] Sales Org / Channel / Division კონფიგურაცია
- [ ] **BP** → Customer Master
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

### 🌰 Hazelnut
- [ ] **CS01** → BOM
- [ ] **CR01** → Work Centers (Farm, Processing)
- [ ] **CA01** → Routing
- [ ] **CO01** → Production Orders

### 🍷 Wine
- [ ] **CS01** → BOM (Grape → Wine → Bottle)
- [ ] **CR01** → Work Centers (Winery)
- [ ] **CO01** → Production Orders

---

## PHASE 7 — Controlling (CO) & Integration 🔧
> Status: ⬜ Planned

- [ ] **OKKP** → Controlling Area
- [ ] **KS01** → Cost Centers: FARM, WINE, DIST, ADMIN
- [ ] **KA01** → Cost Elements
- [ ] **KE51** → Profit Centers: PC-HZL, PC-WIN, PC-FMC
- [ ] **KO01** → Internal Orders
- [ ] MM ↔ FI Integration
- [ ] SD ↔ FI Revenue Recognition
- [ ] PP ↔ CO Cost Allocation
- [ ] `Z_MM_FI_SYNC` → Reconciliation
- [ ] **KSB1** → Cost Center Reports
- [ ] **KE30** → Profitability Analysis

---

## PHASE 8 — Users, Roles & Security 🔐
> Status: ⬜ Planned

- [ ] **SU01/SU10** → 12 Users:
  ```
  QIZI_ADMIN — System Administrator
  QIZI_FI    — Finance Manager
  QIZI_MM    — Procurement Manager
  QIZI_WM    — Warehouse Manager
  QIZI_SD    — Sales Manager
  QIZI_PP    — Production Manager
  QIZI_CO    — Controlling
  QIZI_AP    — AP Clerk
  QIZI_AR    — AR Clerk
  QIZI_WH1   — Warehouse Operator 1
  QIZI_WH2   — Warehouse Operator 2
  QIZI_AUDIT — Read-Only Auditor
  ```
- [ ] **PFCG** → 12 Roles (Least Privilege)
- [ ] SoD Matrix
- [ ] **SU53** → Authorization Testing
- [ ] **SUIM** → Reporting

---

## PHASE 9 — RAP & Modernization 🚀
> Status: ⬜ In Progress (GitHub-ში უკვე არის)

### CDS Views
- [ ] `ZI_WAREHOUSE_STOCK` — Interface View
- [ ] `ZC_WAREHOUSE_STOCK` — Consumption View
- [ ] `ZR_STOCK_KPI` — Reporting View

### RAP Behavior Definition
```abap
managed implementation in class ZBP_WAREHOUSE_STOCK unique;
define behavior for ZI_WAREHOUSE_STOCK alias Stock
  persistent table zstock_db
  draft table zstock_draft
  lock master
  authorization master( global )
{
  field ( mandatory ) : product_id, warehouse_id;
  field ( readonly )  : created_at, created_by;

  determination update_last_modified on modify { create; update; }
  validation validate_quantity on save { create; update; }

  action adjust_stock result [1] $self;

  mapping for zstock_db {
    product_id   = product_id;
    warehouse_id = warehouse_id;
    quantity     = quantity;
  }
}
```

### Services
- [ ] Service Definition + Service Binding → OData V4
- [ ] Draft Handling (Warehouse Adjustments)
- [ ] Fiori Elements: List Report + Object Page
- [ ] Authorization: `Z_QIZI_WM` + `$scope`

---

## System Administration ⚙️ (მუდმივი)

| სამუშაო | T-Code | სიხშირე |
|---------|--------|---------|
| Process Monitoring | SM50 | ყოველდღე |
| Security Audit | SM20 | კვირაში |
| System Log | SM21 | კვირაში |
| DB მონიტორინგი | DB02 | კვირაში |
| Inactive Users | SU01 | თვეში |
| RFC Check | SM59 | თვეში |
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
