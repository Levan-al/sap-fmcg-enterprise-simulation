*&---------------------------------------------------------------------*
*& Report Z_STOCK_VISIBILITY_TOP
*&---------------------------------------------------------------------*
*& Types and Global Data for Stock Visibility Report
*&---------------------------------------------------------------------*

REPORT z_stock_visibility_top.

TYPES: BEGIN OF ty_stock,
         matnr TYPE mard-matnr,
         maktx TYPE makt-maktx,
         werks TYPE mard-werks,
         name1 TYPE t001w-name1,
         lgort TYPE mard-lgort,
         lgobe TYPE t001l-lgobe,
         charg TYPE mard-charg,
         labst TYPE mard-labst,
         insme TYPE mard-insme,
         speme TYPE mard-speme,
         umlme TYPE mard-umlme,
         total TYPE mard-labst,
         meins TYPE mara-meins,
       END OF ty_stock.

TYPES: tt_stock TYPE STANDARD TABLE OF ty_stock WITH EMPTY KEY.

DATA: gt_stock      TYPE tt_stock,
      gt_fieldcat   TYPE slis_t_fieldcat_alv,
      gs_layout     TYPE slis_layout_alv.
