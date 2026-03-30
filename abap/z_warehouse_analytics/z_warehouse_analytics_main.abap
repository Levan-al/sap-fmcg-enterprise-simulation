*&---------------------------------------------------------------------*
*& Report Z_WAREHOUSE_ANALYTICS
*&---------------------------------------------------------------------*
*& Warehouse Analytics and KPI Report
*&---------------------------------------------------------------------*

REPORT z_warehouse_analytics.

INCLUDE z_warehouse_analytics_top.
INCLUDE z_warehouse_analytics_sel.

START-OF-SELECTION.

  PERFORM authority_check.
  PERFORM fetch_and_calculate_kpis.
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
FORM fetch_and_calculate_kpis.
  SELECT 
    d~matnr,
    k~maktx,
    d~werks,
    d~lgort,
    d~charg,
    ( d~labst + d~insme + d~speme + d~umlme ) AS total_stock,
    d~speme AS blocked_stock,
    d~lwmvb AS last_movement   " Last movement date (approximate)
  FROM mard AS d
  LEFT JOIN makt AS k ON k~matnr = d~matnr AND k~spras = sy-langu
  INTO TABLE @gt_analytics
  WHERE d~matnr IN @s_matnr
    AND d~werks IN @s_werks
    AND d~lgort IN @s_lgort.

  " Calculate KPIs
  LOOP AT gt_analytics ASSIGNING FIELD-SYMBOL(<fs>).
    " Days of Supply (simple approximation)
    <fs>-days_supply = 999.  " placeholder - can be enhanced with consumption data

    " Movement Category
    IF <fs>-last_movement < sy-datum - 180.
      <fs>-movement_category = 'DEAD'.
    ELSEIF <fs>-last_movement < sy-datum - 90.
      <fs>-movement_category = 'SLOW'.
    ELSE.
      <fs>-movement_category = 'FAST'.
    ENDIF.

    " ABC Classification (simple value-based)
    IF <fs>-total_stock > 1000.
      <fs>-abc_class = 'A'.
    ELSEIF <fs>-total_stock > 100.
      <fs>-abc_class = 'B'.
    ELSE.
      <fs>-abc_class = 'C'.
    ENDIF.
  ENDLOOP.
ENDFORM.

*&---------------------------------------------------------------------*
FORM build_field_catalog.
  CALL FUNCTION 'REUSE_ALV_FIELDCATALOG_MERGE'
    EXPORTING
      i_structure_name = 'TY_ANALYTICS'
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
      t_outtab           = gt_analytics.
ENDFORM.
