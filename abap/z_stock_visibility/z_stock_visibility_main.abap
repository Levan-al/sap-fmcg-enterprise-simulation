*&---------------------------------------------------------------------*
*& Report Z_STOCK_VISIBILITY
*&---------------------------------------------------------------------*
*& Unified Stock Visibility Report for Warehouse Operations
*&---------------------------------------------------------------------*

REPORT z_stock_visibility.

INCLUDE z_stock_visibility_top.
INCLUDE z_stock_visibility_sel.

START-OF-SELECTION.

  PERFORM authority_check.
  PERFORM fetch_stock_data.
  PERFORM calculate_totals.
  PERFORM build_field_catalog.
  PERFORM display_alv.

*&---------------------------------------------------------------------*
FORM authority_check.
  AUTHORITY-CHECK OBJECT 'M_MATE_WRK'
    ID 'WERKS' FIELD s_werks-low
    ID 'ACTVT' FIELD '03'.   " Display

  IF sy-subrc <> 0.
    MESSAGE 'არ გაქვთ უფლება ამ ქარხანაზე!' TYPE 'E'.
  ENDIF.
ENDFORM.

*&---------------------------------------------------------------------*
FORM fetch_stock_data.
  SELECT 
    m~matnr,
    k~maktx,
    d~werks,
    w~name1,
    d~lgort,
    l~lgobe,
    d~charg,
    d~labst,
    d~insme,
    d~speme,
    d~umlme,
    m~meins
  FROM mard AS d
  INNER JOIN mara AS m ON m~matnr = d~matnr
  LEFT JOIN makt AS k ON k~matnr = d~matnr AND k~spras = sy-langu
  LEFT JOIN t001w AS w ON w~werks = d~werks
  LEFT JOIN t001l AS l ON l~werks = d~werks AND l~lgort = d~lgort
  INTO TABLE @gt_stock
  WHERE d~matnr IN @s_matnr
    AND d~werks IN @s_werks
    AND d~lgort IN @s_lgort
    AND ( @p_batch IS INITIAL OR d~charg = @p_batch ).
ENDFORM.

*&---------------------------------------------------------------------*
FORM calculate_totals.
  LOOP AT gt_stock ASSIGNING FIELD-SYMBOL(<fs>).
    <fs>-total = <fs>-labst + <fs>-insme + <fs>-speme + <fs>-umlme.
  ENDLOOP.
ENDFORM.

*&---------------------------------------------------------------------*
FORM build_field_catalog.
  CALL FUNCTION 'REUSE_ALV_FIELDCATALOG_MERGE'
    EXPORTING
      i_structure_name = 'TY_STOCK'
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
      t_outtab           = gt_stock
    EXCEPTIONS
      OTHERS             = 1.

  IF sy-subrc <> 0.
    MESSAGE 'ALV Display Error' TYPE 'E'.
  ENDIF.
ENDFORM.
