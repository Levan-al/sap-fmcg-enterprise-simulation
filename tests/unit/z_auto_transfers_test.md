# Unit Test Case: Z_AUTO_TRANSFERS

**Test ID:** UT-ZAUTO-001  
**Date:** April 2026  
**Tester:** [Levan]

## Objective
Verify automatic stock transfer from Blocked to Unrestricted stock using BAPI_GOODSMVT_CREATE.

## Preconditions
- Master data and stock exists (Blocked stock > 0)
- Test user has authorization for movement type 321
- Test mode enabled initially

## Test Steps

### Test 1: Test Mode
1. Run `Z_AUTO_TRANSFERS`
2. Select material with blocked stock >= 10
3. Set "Test Mode" = X
4. Execute

**Expected:** No actual posting, message "Test mode - no posting"

### Test 2: Real Posting
1. Run `Z_AUTO_TRANSFERS`
2. Set "Test Mode" = blank
3. Execute

**Expected:**
- BAPI returns success
- Material Document created
- Blocked stock reduced, Unrestricted stock increased
- Success message with document number

## Expected Results
- Correct movement type (321) used
- Proper logging of the transfer
- No negative stock created
- ALV shows status 'S' for successful transfers

## Actual Results
- [To be filled]

## Status
- ☐ Passed
- ☐ Failed

## Notes
Especially important to test BAPI error handling and rollback behavior.
