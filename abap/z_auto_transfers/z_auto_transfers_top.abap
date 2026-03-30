*&---------------------------------------------------------------------*
*& Report Z_AUTO_TRANSFERS_TOP
*&---------------------------------------------------------------------*
*& Types and Global Data for Automatic Stock Transfer
*&---------------------------------------------------------------------*

REPORT z_auto_transfers_top.

TYPES: BEGIN OF ty_transfer,
         matnr TYPE mard-matnr,
         maktx TYPE makt-maktx,
         werks TYPE mard-werks,
         lgort TYPE mard-lgort,
         charg TYPE mard-charg,
         blocked TYPE mard-speme,        " Blocked stock
         unrestricted TYPE mard-labst,   " Unrestricted stock
         transfer_qty TYPE mard-speme,   " Quantity to transfer
         bwart TYPE bapi2017_gm_item-bwart,
         status TYPE char1,              " S = Success, E = Error
         message TYPE bapi_msg,
       END OF ty_transfer.

TYPES: tt_transfer TYPE STANDARD TABLE OF ty_transfer WITH EMPTY KEY.

DATA: gt_transfer   TYPE tt_transfer,
      gt_fieldcat   TYPE slis_t_fieldcat_alv,
      gs_layout     TYPE slis_layout_alv,
      gv_bapi_return TYPE bapiret2_t.
