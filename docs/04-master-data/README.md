# 04 - Master Data

This section describes the master data structure used in the simulation.

## Main Master Data Objects

### Material Master (MM01)
- Finished goods (snacks, confectionery, alcoholic beverages)
- Raw materials
- Different material types and valuation classes

### Business Partners
- Customers (XD01 / BP)
- Vendors (XK01 / BP)

### Organizational Structure
- Company Code
- Plants (e.g. 1000 - Main Plant)
- Storage Locations
- Warehouse Numbers

### Other Master Data
- Bill of Materials (BOM - CS01)
- Info Records (ME11)
- Pricing Conditions

## Master Data Strategy
- Consistent numbering and naming conventions
- Proper account assignment and valuation
- Data quality checks before process execution
- Separation between master data maintenance and transactional users (SoD)

## Role Responsibility
- Z_MASTER role handles master data creation and maintenance
- Other roles have display or limited access only
