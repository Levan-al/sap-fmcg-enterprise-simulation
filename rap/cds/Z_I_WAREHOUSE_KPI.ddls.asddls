@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Warehouse KPIs - Analytical View'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity Z_I_WAREHOUSE_KPI
  as select from Z_I_WAREHOUSE_STOCK
{
  key MaterialNumber,
  key Plant,
  key StorageLocation,
  key Batch,

      MaterialDescription,
      MaterialType,
      PlantName,

      UnrestrictedStock,
      BlockedStock,
      UnitOfMeasure,

      // Simple KPI calculations (can be enhanced with consumption data)
      case 
        when UnrestrictedStock > 1000 then 'A'
        when UnrestrictedStock > 100  then 'B'
        else 'C'
      end as ABCClass,

      case 
        when UnrestrictedStock = 0 then 'DEAD'
        when UnrestrictedStock < 50 then 'SLOW'
        else 'FAST'
      end as MovementCategory,

      // Placeholder values - in real project these would be calculated from actual consumption
      cast( 0 as abap.dec( 10, 2 ) ) as InventoryTurnover,
      cast( 999 as abap.int4 )      as DaysOfSupply,

      $session.system_date as LastCalculationDate
}
