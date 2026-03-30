*&---------------------------------------------------------------------*
*& Report Z_WAREHOUSE_ANALYTICS_TOP
*&---------------------------------------------------------------------*
*& Types and Global Data for Warehouse Analytics
*&---------------------------------------------------------------------*

REPORT z_warehouse_analytics_top.

TYPES: BEGIN OF ty_analytics,
         matnr TYPE mard-matnr,
         maktx TYPE makt-maktx,
         werks TYPE mard-werks,
         lgort TYPE mard-lgort,
         charg TYPE mard-charg,
         total_stock TYPE mard-labst,
         blocked_stock TYPE mard-speme,
         turnover TYPE p DECIMALS 2,
         days_supply TYPE i,
         abc_class TYPE char1,
         movement_category TYPE char4,   " FAST, SLOW, DEAD
         last_movement TYPE d,
       END OF ty_analytics.

TYPES: tt_analytics TYPE STANDARD TABLE OF ty_analytics WITH EMPTY KEY.

DATA: gt_analytics  TYPE tt_analytics,
      gt_fieldcat   TYPE slis_t_fieldcat_alv,
      gs_layout     TYPE slis_layout_alv.
