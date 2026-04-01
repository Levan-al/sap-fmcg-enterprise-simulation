@EndUserText.label: 'Warehouse Stock - OData V4 Service Binding'
@UI.service.binding: {
  type: #ODATA_V4_UI,
  uiTechnology: #Fiori_Elements
}
service Z_UI_WAREHOUSE_STOCK_V4
{
  expose Z_UI_WAREHOUSE_STOCK as WarehouseStock;
}
