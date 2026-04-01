# Unit Test Case: Z_AUTO_TRANSFERS - BAPI Success & Logging

**Test ID:** UT-ZAUTO-BAPI-SUCCESS-001  
**Date:** April 2026  

## Objective
Verify successful BAPI posting and proper logging.

## Test Steps

1. Ensure material has blocked stock > 10
2. Run `Z_AUTO_TRANSFERS`
3. Select the material
4. Set "Test Mode" = blank
5. Set Movement Type = 321
6. Execute

## Expected Results
- BAPI returns success (SY-SUBRC = 0)
- Material Document number is generated and shown in message
- Blocked stock decreased
- Unrestricted stock increased by the same amount
- Entry appears in ALV with Status = 'S'
- Log entry created in SLG1 (or custom log table)

## Verification Points
- Stock balance before vs after (MARD)
- Material Document exists (MSEG/MKPF)
- Accounting document created (if applicable)
- Audit trail / log contains user, date, quantity, material

## Status
- ☐ Passed

## Notes
This test confirms the core functionality of automatic warehouse transfers.
