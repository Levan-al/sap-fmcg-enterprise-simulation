@EndUserText.label: 'Warehouse Stock Service Definition'
define service Z_UI_WAREHOUSE_STOCK
{
  expose Z_I_WAREHOUSE_STOCK as WarehouseStock;
  expose Z_I_WAREHOUSE_KPI   as WarehouseKPI;
}
