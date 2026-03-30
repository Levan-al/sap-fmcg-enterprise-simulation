*&---------------------------------------------------------------------*
*& Report Z_MM_FI_SYNC
*&---------------------------------------------------------------------*
*& MM-FI Synchronization and Reconciliation Report
*&---------------------------------------------------------------------*

REPORT z_mm_fi_sync.

INCLUDE z_mm_fi_sync_top.
INCLUDE z_mm_fi_sync_sel.

START-OF-SELECTION.

  PERFORM authority_check.
  PERFORM detect_mismatches.
  PERFORM build_field_catalog.
  PERFORM display_alv.

*&---------------------------------------------------------------------*
FORM authority_check.
  AUTHORITY-CHECK OBJECT 'M_MATE_WRK'
    ID 'WERKS' FIELD s_werks-low
    ID 'ACTVT' FIELD '03'.

  IF sy-subrc <> 0.
    MESSAGE 'არ გაქვთ უფლება ამ ქარხანაზე!' TYPE 'E'.
  ENDIF.
ENDFORM.

*&---------------------------------------------------------------------*
FORM detect_mismatches.
  " Example logic: Find material documents without corresponding FI posting or with amount mismatch
  SELECT 
    m~mblnr,
    m~mjahr,
    m~matnr,
    k~maktx,
    m~werks,
    m~menge,
    m~dmbtr AS dmbtr_mm,
    ' ' AS belnr_fi,
    0 AS dmbtr_fi,
    'MISS' AS error_type,
    'No corresponding FI document found' AS message
  FROM mseg AS m
  LEFT JOIN makt AS k ON k~matnr = m~matnr AND k~spras = sy-langu
  INTO TABLE @gt_mismatch
  WHERE m~matnr IN @s_matnr
    AND m~werks IN @s_werks
    AND m~mjahr = @sy-datum+0(4).   " Current year example

  " Placeholder for real MM-FI comparison logic (can be enhanced with BSEG join)
  LOOP AT gt_mismatch ASSIGNING FIELD-SYMBOL(<fs>).
    <fs>-difference = <fs>-dmbtr_mm - <fs>-dmbtr_fi.
  ENDLOOP.
ENDFORM.

*&---------------------------------------------------------------------*
FORM build_field_catalog.
  CALL FUNCTION 'REUSE_ALV_FIELDCATALOG_MERGE'
    EXPORTING
      i_structure_name = 'TY_MISMATCH'
    CHANGING
      ct_fieldcat      = gt_fieldcat.
ENDFORM.

*&---------------------------------------------------------------------*
FORM display_alv.
  gs_layout-zebra = 'X'.
  gs_layout-colwidth_optimize = 'X'.

  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
    EXPORTING
      i_callback_program = sy-repid
      is_layout          = gs_layout
      it_fieldcat        = gt_fieldcat
    TABLES
      t_outtab           = gt_mismatch.
ENDFORM.
