# Tests

Comprehensive testing documentation for the SAP FMCG Enterprise Simulation project.

## Testing Strategy

### 1. Unit Testing
- Individual validation of each Z-report
- Selection screen, authorization checks, ALV output, error handling

### 2. Integration Testing
- Full Procure-to-Pay (P2P) cycle
- Full Order-to-Cash (OTC) cycle
- MM-FI reconciliation using z_mm_fi_sync
- Warehouse automation flows

### 3. Process & User Testing
- End-to-end scenarios with 11 test users
- Role-based access and Segregation of Duties (SoD) validation
- Error injection and recovery scenarios

### 4. Performance Testing
- Large data volume processing in Z-reports
- Response time validation for analytics reports

## Test Deliverables
- Unit test cases per Z-report
- Integration test scripts
- Error scenarios catalog
- Reconciliation checklists

## How to Run Tests
1. Import master data from `data/master-data/`
2. Create test users and assign roles
3. Execute processes using provided transactional examples
4. Validate results using Z-reports and standard transactions
