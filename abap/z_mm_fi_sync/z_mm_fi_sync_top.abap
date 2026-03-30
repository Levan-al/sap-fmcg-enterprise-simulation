*&---------------------------------------------------------------------*
*& Report Z_MM_FI_SYNC_TOP
*&---------------------------------------------------------------------*
*& Types and Global Data for MM-FI Reconciliation
*&---------------------------------------------------------------------*

REPORT z_mm_fi_sync_top.

TYPES: BEGIN OF ty_mismatch,
         mblnr TYPE mkpf-mblnr,          " Material Document
         mjahr TYPE mkpf-mjahr,
         matnr TYPE mseg-matnr,
         maktx TYPE makt-maktx,
         werks TYPE mseg-werks,
         bwart TYPE mseg-bwart,
         menge TYPE mseg-menge,
         dmbtr_mm TYPE mseg-dmbtr,       " Amount in MM
         belnr_fi TYPE bkpf-belnr,       " FI Document
         dmbtr_fi TYPE bseg-dmbtr,       " Amount in FI
         difference TYPE p DECIMALS 2,
         error_type TYPE char4,          " AMNT, QTY, MISS
         message TYPE bapi_msg,
       END OF ty_mismatch.

TYPES: tt_mismatch TYPE STANDARD TABLE OF ty_mismatch WITH EMPTY KEY.

DATA: gt_mismatch   TYPE tt_mismatch,
      gt_fieldcat   TYPE slis_t_fieldcat_alv,
      gs_layout     TYPE slis_layout_alv.
