# Unit Tests

Unit test cases for individual Z-reports.

## Test Cases

| Z-Report                    | Test Scenario                          | Expected Result                     | Status |
|-----------------------------|----------------------------------------|-------------------------------------|--------|
| z_stock_visibility          | Display stock with filters             | ALV grid with correct data          | Done   |
| z_movement_control          | Movement validation                    | Errors shown for invalid movements  | Done   |
| z_auto_transfers            | Test mode + real posting               | Correct BAPI behavior               | Done   |
| ...                         | ...                                    | ...                                 | ...    |

## How to Execute
- Run each report in test client (Client 500)
- Use selection screen parameters from test data
- Validate authorization, output and error handling
