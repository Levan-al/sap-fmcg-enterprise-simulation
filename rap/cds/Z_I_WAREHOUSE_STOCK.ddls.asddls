@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Warehouse Stock - Interface View'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity Z_I_WAREHOUSE_STOCK
  as select from mard as Stock
    inner join   mara as Material on Material.matnr = Stock.matnr
    left outer join makt as Text on  Text.matnr = Stock.matnr
                                 and Text.spras = $session.system_language
    left outer join t001w as Plant on Plant.werks = Stock.werks
{
  key Stock.matnr as MaterialNumber,
  key Stock.werks as Plant,
  key Stock.lgort as StorageLocation,
  key Stock.charg as Batch,

      Material.mtart as MaterialType,
      Text.maktx   as MaterialDescription,
      Plant.name1  as PlantName,

      @Semantics.quantity.unitOfMeasure: 'UnitOfMeasure'
      Stock.labst  as UnrestrictedStock,

      @Semantics.quantity.unitOfMeasure: 'UnitOfMeasure'
      Stock.insme  as QualityInspectionStock,

      @Semantics.quantity.unitOfMeasure: 'UnitOfMeasure'
      Stock.speme  as BlockedStock,

      @Semantics.quantity.unitOfMeasure: 'UnitOfMeasure'
      Stock.umlme  as TransferStock,

      Material.meins as UnitOfMeasure,

      @Semantics.amount.currencyCode: 'Currency'
      cast( 0 as abap.curr( 15, 2 ) ) as StockValue
}
