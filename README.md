# SAP FMCG Enterprise Process Simulation

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
![SAP](https://img.shields.io/badge/SAP-ABAP%20%7C%20RAP%20%7C%20CDS-blue)

## 🎯 Goal

Realistic **end-to-end SAP simulation** of an FMCG distribution company in a controlled training environment (Client 500).

The project focuses on understanding **how business processes, system architecture, custom development, and integration** work together — not just executing individual transactions.

**Business Scope**: Snacks • Confectionery • Alcoholic Beverages

**Full Cycle**: Procurement → Warehouse → Production → Sales → Delivery → Billing → Finance

## 🚀 Key Achievements

- **7 Modular Z-Reports** with clean ABAP best practices (TOP/SEL/MAIN structure)
- **Warehouse Automation**: Stock visibility, movement control, automatic transfers, analytics, error detection & reconciliation
- **User Management & Security**: 11 test users + 11 roles with proper Segregation of Duties (SoD)
- **Modern Technologies**: CDS Views + RAP layer (Service Definition, Binding, Behavior with Actions)
- **Comprehensive Documentation** + Mermaid diagrams + test cases + sample data

## 🏗️ Architecture Layers

- **Standard SAP** – Core transactions (MM, WM, PP, SD, FI)
- **Custom Z-Layer** – 7 warehouse-focused reports
- **Analytical Layer** – CDS Views for stock and KPIs
- **RAP Layer** – Behavior Definitions, OData services (Fiori readiness)
- **Integration Layer** – MM-FI sync, SD-WM consistency, error handling

## 📁 Repository Structure
sap-fmcg-enterprise-simulation/
├── docs/                    # 09 detailed documentation sections
├── diagrams/                # 8 Mermaid diagrams
├── abap/                    # 7 modular Z-reports
├── rap/                     # CDS + Behavior + Services
├── data/                    # Master & transactional sample data (CSV)
├── tests/                   # Unit test cases (including BAPI)
├── tools/                   # Templates (transport, roles, checklist)
└── screenshots/             # Visual examples


## Highlights

- Strong **process thinking** and real-world integration focus
- Clean, maintainable, and scalable ABAP code
- Authorization, SoD, and security concepts implemented
- Preparation for modern SAP (CDS + RAP)

## Areas for Future Development

- Full Fiori Elements applications via RAP
- More screenshots and demo flows
- Advanced test automation
- Performance tuning for large data volumes

---

**Feedback Welcome**

I would greatly appreciate your honest and critical feedback on:
- Architecture and design decisions
- Quality and best practices of the Z-code
- Balance between standard vs custom development
- What is missing or could be improved
- Overall impression as a showcase / portfolio project

No need to be polite — direct feedback is exactly what I'm looking for.

Thank you in advance for your time!

Levan Alughishvili — April 2026
