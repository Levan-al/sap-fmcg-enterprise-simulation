*&---------------------------------------------------------------------*
*& Report Z_ERROR_DETECTION_TOP
*&---------------------------------------------------------------------*
*& Types and Global Data for Error Detection
*&---------------------------------------------------------------------*

REPORT z_error_detection_top.

TYPES: BEGIN OF ty_error,
         matnr TYPE mard-matnr,
         maktx TYPE makt-maktx,
         werks TYPE mard-werks,
         lgort TYPE mard-lgort,
         charg TYPE mard-charg,
         labst TYPE mard-labst,          " Unrestricted
         speme TYPE mard-speme,          " Blocked
         negative_stock TYPE abap_bool,
         mm_fi_mismatch TYPE abap_bool,
         error_type TYPE char4,          " NEGS, MISF, INCM
         message TYPE bapi_msg,
         last_check TYPE d,
       END OF ty_error.

TYPES: tt_error TYPE STANDARD TABLE OF ty_error WITH EMPTY KEY.

DATA: gt_error      TYPE tt_error,
      gt_fieldcat   TYPE slis_t_fieldcat_alv,
      gs_layout     TYPE slis_layout_alv.
