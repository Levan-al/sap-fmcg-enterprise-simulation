# 09 - User Management and Authorization

This section describes the user management, role design, and security concept implemented in the project.

## Overview

- **11 Test Users** created in Client 500
- **11 Business Roles** with proper segregation of duties (SoD)
- Role-Based Access Control (RBAC) model
- Training vs Production environment differences considered

## User Structure (11 Users)

| User ID     | Role                          | Main Responsibility                  | Module Focus          |
|-------------|-------------------------------|--------------------------------------|-----------------------|
| ZUSER01     | Z_MM_PURCH                    | Procurement                          | MM                    |
| ZUSER02     | Z_MM_INV_ADV                  | Warehouse Operations                 | WM / MM               |
| ZUSER03     | Z_SD_SALES_ADV                | Sales Order Processing               | SD                    |
| ZUSER04     | Z_SD_BILLING                  | Billing                              | SD                    |
| ZUSER05     | Z_FI_AP                       | Accounts Payable                     | FI                    |
| ZUSER06     | Z_FI_AR                       | Accounts Receivable                  | FI                    |
| ZUSER07     | Z_FI_GL                       | General Ledger                       | FI                    |
| ZUSER08     | Z_MANAGER                     | Manager / Reporting                  | All                   |
| ZUSER09     | Z_PP_PROD                     | Production                           | PP                    |
| ZUSER10     | Z_LOGISTICS                   | Logistics & Delivery                 | SD / WM               |
| ZUSER11     | Z_MASTER                      | Master Data Maintenance              | All                   |

## Role Structure (11 Roles)

| Role ID               | Description                              | Key T-codes                              | SoD Consideration |
|-----------------------|------------------------------------------|------------------------------------------|-------------------|
| Z_MM_PURCH            | Procurement Specialist                   | ME21N, ME51N, ME11                       | No payment rights |
| Z_MM_INV_ADV          | Advanced Warehouse User                  | MIGO, MB52, LX03, LT01                   | No FI access      |
| Z_SD_SALES_ADV        | Advanced Sales User                      | VA01, VL01N, VA05                        | No billing        |
| Z_SD_BILLING          | Billing Specialist                       | VF01, VF05                               | No delivery       |
| Z_FI_AP               | Accounts Payable                         | MIRO, F-53                               | No PO creation    |
| Z_FI_AR               | Accounts Receivable                      | F-28, FBL5N                              | No sales order    |
| Z_FI_GL               | General Ledger Accountant                | FBL3N, FB01                              | Limited access    |
| Z_MANAGER             | Management Reporting                     | MB52, VA05, FBL3N                        | Display only      |
| Z_PP_PROD             | Production User                          | CO01, CS01                               | No MM access      |
| Z_LOGISTICS           | Logistics Coordinator                    | VL01N, VL02N                             | No financial      |
| Z_MASTER              | Master Data Administrator                | MM01, XD01, XK01                         | Limited          |

## Segregation of Duties (SoD)

**Critical SoD Rules Implemented:**

- One user **cannot** create PO + approve payment
- One user **cannot** create delivery + post invoice
- Warehouse user **cannot** post FI documents
- Master Data user has limited transactional access

## Technical Implementation

- Users created via **SU01** / mass maintenance via **SU10**
- Roles created and maintained via **PFCG**
- Authorization objects checked in Z-reports (`AUTHORITY-CHECK`)
- SU53 used for troubleshooting access issues
- Periodic access review recommended (SUIM)

## Training vs Real-World Differences

- Training: Broad access for learning purposes
- Real Production: Much stricter SoD and approval workflows
- SAP_ALL used only for setup, never for business users

This user and authorization concept demonstrates understanding of enterprise security principles and real-world compliance requirements.
