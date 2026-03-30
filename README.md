# sap-fmcg-enterprise-simulation
Realistic end-to-end SAP FMCG distribution system simulation with custom ABAP, CDS Views and enterprise architecture
# SAP Enterprise Process Simulation

## Goal

Simulate a **realistic SAP-based enterprise system** in a controlled training environment (Client 500).

The main objective is not only to learn individual SAP modules (MM, SD, PP, FI, WM), but to understand **how business processes, system architecture, and custom development interact** in a real-world FMCG distribution company.

## Business Scenario

FMCG Distribution Company specializing in:
- Snacks
- Confectionery
- Alcoholic beverages

The system covers the **full end-to-end business cycle**:
**Procurement → Inventory → Production → Sales → Delivery → Billing → Finance**

## Why This Project

Real SAP implementations rarely rely only on standard functionality.  
This project demonstrates:
- Where and why standard SAP is not sufficient
- How to properly extend it with clean, modular ABAP development
- Modern development practices (CDS Views, RAP readiness)
- Strong process-level thinking and enterprise architecture

## Current Status

**Implemented:**
- Core MM, WM, PP, SD, FI processes configured
- Complete master data structure
- 7 modular Z-reports for warehouse operations (with authorization, logging, ALV)
- CDS Views for stock overview and warehouse KPIs (turnover, days of supply, ABC classification, slow/dead stock)
- 11 business roles + 11 test users with proper authorization and SoD simulation
- Detailed architecture and process documentation with Mermaid diagrams

**In Progress:**
- RAP / Fiori Elements applications (warehouse dashboard, KPI monitoring)
- Advanced integration and validation scenarios

## Architecture Layers

- **Standard SAP Layer** – Core transactions and processes
- **Custom Z-Layer** – Modular ABAP extensions where standard is not enough
- **CDS / Analytical Layer** – Modern data modeling and KPI calculations
- **RAP / Fiori Layer** – Modern user interface (planned)
- **Integration Layer** – Cross-module consistency

## Main Areas Covered

- MM / Procurement
- Warehouse Operations (WM)
- Production (PP)
- Sales & Distribution (SD)
- Finance Integration (FI)

## Development Highlights

Custom ABAP tools developed:
- Stock Visibility Report
- Goods Movement Control
- Warehouse Analytics & KPIs
- Delivery & Billing monitoring
- Audit trail and error detection

## Repository Structure

- `docs/` → Business context, architecture and technical documentation
- `diagrams/` → Visual architecture and process flows (Mermaid)
- `abap/` → Custom modular Z-development
- `cds-views/` → CDS Views for stock and analytics
- `rap/` → RAP services and Fiori readiness
- `tests/` → Test cases and scenarios
- `data/` → Sample master and transactional data
- `screenshots/` → Visual examples
