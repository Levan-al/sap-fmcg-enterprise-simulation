# 07 - Testing

This section describes the testing strategy used in the project.

## Testing Types

### 1. Unit Testing
- Individual Z-report testing (selection screen, authorization, output)
- BAPI testing in test mode (`p_test = 'X'`)

### 2. Integration Testing
- End-to-end P2P cycle (ME21N → MIGO → MIRO)
- End-to-end OTC cycle (VA01 → VL01N → VF01 → F-28)
- MM-FI reconciliation scenarios

### 3. Process Testing
- Full business cycle simulation with 11 test users
- Role-based access validation (SoD checks)
- Error scenarios (negative stock, mismatches)

### 4. Performance Testing
- Large data volume simulation for stock reports
- ALV performance with Field-Symbols

## Test Users & Roles
- 11 test users (ZUSER01 – ZUSER11)
- Dedicated roles for each process area
- Segregation of Duties validation

## Test Data
- Master data (materials, vendors, customers)
- Transactional data examples
- Predefined error scenarios for testing

## Tools Used
- Standard SAP transactions for validation
- Custom Z-reports for monitoring
- Manual reconciliation scripts
