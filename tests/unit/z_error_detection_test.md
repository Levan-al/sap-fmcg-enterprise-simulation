# Unit Test Case: Z_ERROR_DETECTION

**Test ID:** UT-ZERR-001  
**Date:** April 2026  

## Objective
Verify error detection for negative stock and MM-FI mismatches.

## Test Steps

1. Run `Z_ERROR_DETECTION`
2. Select plant 1000
3. Execute

**Expected Results:**
- Report shows records with negative stock (if any)
- MM-FI mismatch examples displayed
- Clear error type and message columns
- Proper filtering works (negative stock only, mismatches only)

## Test Scenarios
- Negative unrestricted stock
- Negative blocked stock
- MM-FI amount mismatch simulation

## Status
- ☐ Passed

## Notes
This report is critical for data quality and financial integrity.
