# Data

Sample master data and transactional data for the SAP FMCG Enterprise Simulation.

## Purpose
- Enable quick setup and testing of the entire system
- Provide realistic FMCG data (snacks, confectionery, alcoholic beverages)
- Support consistent demonstration of Z-reports and processes
- Serve as reference for data model and integration testing

## Folder Structure

- **master-data/** → Core master records (materials, business partners, etc.)
- **transactional-data/** → Example documents and movements

## Usage Recommendations
- Import master data first (MM01, XD01, XK01, CS01)
- Use transactional data to run full P2P and OTC cycles
- Combine with test users and roles for complete simulation

## Future Enhancements
- Excel upload templates
- LSMW / LTMC templates
- Test data generation scripts
