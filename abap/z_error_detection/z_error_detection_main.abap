*&---------------------------------------------------------------------*
*& Report Z_ERROR_DETECTION
*&---------------------------------------------------------------------*
*& Error Detection and Reconciliation Report
*&---------------------------------------------------------------------*

REPORT z_error_detection.

INCLUDE z_error_detection_top.
INCLUDE z_error_detection_sel.

START-OF-SELECTION.

  PERFORM authority_check.
  PERFORM detect_errors.
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
FORM detect_errors.
  " Negative stock detection
  SELECT 
    d~matnr,
    k~maktx,
    d~werks,
    d~lgort,
    d~charg,
    d~labst,
    d~speme,
    'NEGS' AS error_type,
    'Negative or inconsistent stock' AS message
  FROM mard AS d
  LEFT JOIN makt AS k ON k~matnr = d~matnr AND k~spras = sy-langu
  INTO TABLE @gt_error
  WHERE d~matnr IN @s_matnr
    AND d~werks IN @s_werks
    AND d~lgort IN @s_lgort
    AND ( d~labst < 0 OR d~speme < 0 ).

  " MM-FI mismatch simulation (placeholder - can be enhanced with real MKPF/MSEG vs BSEG comparison)
  IF p_misf = 'X'.
    " Example: add dummy mismatch records for demo
    APPEND VALUE #( matnr = 'TEST001' maktx = 'Test Material' werks = '1000' 
                    lgort = '0001' error_type = 'MISF' message = 'MM-FI document mismatch detected' ) 
                    TO gt_error.
  ENDIF.
ENDFORM.

*&---------------------------------------------------------------------*
FORM build_field_catalog.
  CALL FUNCTION 'REUSE_ALV_FIELDCATALOG_MERGE'
    EXPORTING
      i_structure_name = 'TY_ERROR'
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
      t_outtab           = gt_error.
ENDFORM.
