# 10 - Organizational Structure

This section documents the SAP organizational structure implemented for **Qizi LLC (შპს ქიზი)** in Client 700.

## Company Overview

| Field              | Value                                      |
|--------------------|--------------------------------------------|
| Legal Name         | შპს ქიზი (Qizi LLC)                        |
| ID Number          | 428522495                                  |
| Country            | Georgia (GE)                               |
| City               | Tbilisi                                    |
| Currency           | GEL                                        |

## Business Scope

Qizi LLC operates in three main business areas:

1. **🌰 Hazelnut Production** — 15 hectares of hazelnut farm, first harvest starting now
2. **🍷 Wine Production** — Bottled wine, ready for sale
3. **📦 FMCG Distribution** — Distribution of non-perishable FMCG products to retail chains (Carrefour, Goodwill, Agrohub, Nikora, etc.)

## SAP Organizational Structure

### 1. Company Code

| Field         | Value                  |
|---------------|------------------------|
| Company Code  | QIZI                   |
| Name          | Qizi LLC               |
| City          | Tbilisi                |
| Country       | GE                     |
| Currency      | GEL                    |
| Language      | EN                     |

**Transaction used:** OX02

### 2. Tax Configuration

| Field               | Value                          |
|---------------------|--------------------------------|
| Country             | GE — Georgia                   |
| Tax Procedure       | TAXGEO                         |

**Note:** TAXGEO was created as a new Tax Calculation Procedure for Georgia, since no standard Georgian tax procedure existed in the system.

**Transactions used:** OBBG, OBYZ

### 3. Region Configuration

| Country | Region Code | Name     |
|---------|-------------|----------|
| GE      | TB          | Tbilisi  |

**Path:** SPRO → SAP NetWeaver → General Settings → Set Countries → Insert Regions

### 4. Plants

| Plant | Name                        | City     | Country | Purpose                              |
|-------|-----------------------------|----------|---------|--------------------------------------|
| QZ01  | Qizi Hazelnut Farm          | Tbilisi  | GE      | Hazelnut cultivation & processing    |
| QZ02  | Qizi Winery                 | Tbilisi  | GE      | Wine production & bottling           |
| QZ03  | Qizi Distribution Center    | Tbilisi  | GE      | FMCG distribution hub                |

**Transaction used:** OX10

### 5. Plant → Company Code Assignment

| Company Code | Plant |
|--------------|-------|
| QIZI         | QZ01  |
| QIZI         | QZ02  |
| QIZI         | QZ03  |

**Transaction used:** OX18

## Next Steps

- [ ] Storage Locations (OX09)
- [ ] Sales Organization (OVX5)
- [ ] Distribution Channels (OVXI)
- [ ] Divisions (OVXB)
- [ ] Sales Area Assignments (OVXG)
- [ ] Warehouse Number (SPRO)
- [ ] Sales Org → Company Code Assignment (OVX3)

## Implementation Notes

- **Client:** 700
- **Environment:** SAP S/4HANA On-Premise
- **Development Tool:** SAP GUI
- **Implementation Date:** April 2026
- **Implemented by:** Levan Alughishvili
