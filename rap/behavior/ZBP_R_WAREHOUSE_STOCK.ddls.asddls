@EndUserText.label: 'Behavior Definition for Warehouse Stock'
@AccessControl.authorizationCheck: #CHECK
define behavior for Z_I_WAREHOUSE_STOCK
persistent table mard
lock master
authorization master ( instance )
{

  // Standard operations
  create;
  update;
  delete;

  // Custom actions
  action CalculateKPIs result [1] $self;
  action TransferStock parameter Z_I_TRANSFER_STOCK result [1] $self;

  // Determinations
  determination CalculateTotalStock on modify { create; update; }

  // Validations
  validation ValidateStock on save { create; update; }

}
