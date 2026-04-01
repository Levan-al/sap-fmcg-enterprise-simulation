# Unit Test Case: Z_AUTO_TRANSFERS - BAPI Error Handling

**Test ID:** UT-ZAUTO-BAPI-ERR-001  
**Date:** April 2026  
**Component:** BAPI_GOODSMVT_CREATE

## Objective
Test proper error handling and rollback when BAPI fails.

## Preconditions
- Material with insufficient or locked stock
- Test user with limited authorization

## Test Steps

1. Run `Z_AUTO_TRANSFERS`
2. Select material with zero or negative blocked stock
3. Set "Test Mode" = blank (real posting)
4. Execute

## Expected Results
- BAPI returns error messages in RETURN table
- Status = 'E' in ALV output
- No material document is created
- No stock is changed (rollback successful)
- Clear error message displayed to user (e.g. "Movement not possible" or "Insufficient stock")

## Test Scenarios to Cover
- Insufficient blocked quantity
- Invalid movement type
- Authorization failure for plant/storage location
- Material locked by another user

## Actual Results
- [To be filled after execution]

## Status
- ☐ Passed
- ☐ Failed

## Notes
Critical test for data integrity. BAPI errors must never cause inconsistent stock.
