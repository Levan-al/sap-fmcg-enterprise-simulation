# SAP FMCG Enterprise Process Simulation

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
![SAP](https://img.shields.io/badge/SAP-ABAP%20%7C%20RAP%20%7C%20CDS-blue)

## 🎯 Project Goal

Realistic **end-to-end SAP simulation** of an FMCG distribution company in a training environment (Client 500).

The focus is not only on executing transactions, but on understanding **how business processes, architecture, and custom development work together**.

**Business Scope**: Snacks • Confectionery • Alcoholic Beverages

**Full Cycle**: Procurement → Warehouse → Production → Sales → Delivery → Billing → Finance

## 🚀 Key Features

- **7 Modular Z-Reports** with clean TOP/SEL/MAIN structure
- **Warehouse Automation**: Stock visibility, automatic transfers, movement control, analytics, error detection
- **MM-FI Reconciliation** and cross-module integration
- **User Management & Authorization**: 11 users + 11 roles with SoD (Segregation of Duties)
- **Modern Development**: CDS Views + RAP readiness (Service Definition & Binding)
- **Rich Documentation**: Architecture, processes, design decisions and Mermaid diagrams

## 🏗️ Architecture Layers

- **Standard SAP** – Core transactions (ME21N, MIGO, VA01, VL01N, MIRO…)
- **Custom Z-Layer** – 7 warehouse-focused reports with best practices
- **Analytical Layer** – CDS Views (`Z_I_WAREHOUSE_STOCK`, `Z_I_WAREHOUSE_KPI`)
- **RAP Layer** – OData V4 services for future Fiori Elements apps
- **Integration Layer** – MM-FI sync, error detection, reconciliation

## 📁 Repository Structure

sap-fmcg-enterprise-simulation/
├── docs/                    # Detailed documentation (01-08)
├── diagrams/                # Business, Technical & Security diagrams (Mermaid)
├── abap/                    # 7 modular Z-reports
├── rap/                     # CDS Views + Service Definition + Binding
├── screenshots/             # Visual examples
├── tests/                   # Test scenarios
└── data/                    # Sample master & transactional data


## 📊 Highlights

- Strong **process thinking** (P2P + OTC cycles)
- Clean, maintainable ABAP code
- Real-world integration challenges addressed
- Preparation for modern SAP (CDS + RAP)
- Ready for senior ABAP / SAP consultant discussions

## 🎓 Learning Outcomes

- Deep understanding of SAP modules integration
- When and how to use custom development
- Authorization, SoD and security concepts
- Documentation and architecture visualization

---

**Feedback Welcome**  
I would greatly appreciate your critical review on:
- Architecture and design decisions
- Z-code quality and best practices
- What is missing or over-engineered
- How to make it even closer to real business usage

Thank you for your time! 🙌

**Last updated**: April 2026
