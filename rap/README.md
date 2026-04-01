# RAP Layer (RESTful ABAP Programming Model)

This folder contains modern SAP development artifacts using the **RAP** model.

## Objectives
- Expose warehouse data as OData services
- Build Fiori Elements applications (Warehouse Dashboard, KPI Cockpit)
- Prepare the project for S/4HANA and cloud-ready development

## Folder Structure
rap/
├── cds/           # CDS Views (Interface + Consumption)
├── behavior/      # Behavior Definitions
├── services/      # Service Definitions and Bindings
└── README.md

## Current Status
- CDS Views designed (Z_I_WAREHOUSE_STOCK, Z_I_WAREHOUSE_KPI)
- Behavior Definitions and OData Services — planned for next phase
- Goal: Replace classical ALV reports with modern Fiori UI in the future

## Next Steps
- Create Consumption CDS Views
- Define Behavior Definitions
- Create OData V4 Service Binding
- Develop Fiori Elements List + Object Page apps
