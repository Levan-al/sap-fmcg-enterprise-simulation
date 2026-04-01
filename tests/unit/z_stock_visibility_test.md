# Unit Test Case: Z_STOCK_VISIBILITY

**Test ID:** UT-ZSTOCK-001  
**Date:** April 2026  
**Tester:** [Levan]

## Objective
Verify that the Stock Visibility report displays correct data with proper authorization and filtering.

## Preconditions
- Master data imported (materials.csv)
- Test user ZUSER02 assigned to Warehouse role
- Stock exists in MARD table for plant 1000

## Test Steps

1. Log in as ZUSER02
2. Run transaction `Z_STOCK_VISIBILITY`
3. Enter selection:
   - Material: 10000001 - 10000005
   - Plant: 1000
   - Storage Location: 0001
4. Execute (F8)

## Expected Results
- ALV grid displays with columns: Material, Description, Plant, Storage Loc, Batch, Unrestricted, Blocked, Total
- Data matches MARD table values
- Field-Symbols used for performance
- Authorization check passed (no error message)
- Totals row shown correctly

## Actual Results
- [To be filled after execution]

## Status
- ☐ Passed
- ☐ Failed
- ☐ Not Tested

## Notes / Issues
