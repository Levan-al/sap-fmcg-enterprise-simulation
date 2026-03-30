*&---------------------------------------------------------------------*
*& Report Z_MOVEMENT_CONTROL
*&---------------------------------------------------------------------*
*& Goods Movement Control with Validation and Authorization
*&---------------------------------------------------------------------*

REPORT z_movement_control.

INCLUDE z_movement_control_top.
INCLUDE z_movement_control_sel.

START-OF-SELECTION.

  PERFORM authority_check.
  PERFORM fetch_movement_data.
  PERFORM validate_movements.
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
FORM fetch_movement_data.
  SELECT 
    m~mblnr,
    m~mjahr,
    m~zeile,
    m~matnr,
    k~maktx,
    m~werks,
    m~lgort,
    m~bwart,
    t~btext,
    m~menge,
    m~meins,
    p~budat,
    p~usnam
  FROM mseg AS m
  INNER JOIN mkpf AS p ON p~mblnr = m~mblnr AND p~mjahr = m~mjahr
  LEFT JOIN makt AS k ON k~matnr = m~matnr AND k~spras = sy-langu
  LEFT JOIN t156t AS t ON t~bwart = m~bwart AND t~spras = sy-langu
  INTO TABLE @gt_movement
  WHERE m~matnr IN @s_matnr
    AND m~werks IN @s_werks
    AND m~lgort IN @s_lgort
    AND m~bwart IN @s_bwart
    AND p~budat = @p_date.
ENDFORM.

*&---------------------------------------------------------------------*
FORM validate_movements.
  LOOP AT gt_movement ASSIGNING FIELD-SYMBOL(<fs>).
    " Simple validation example - can be expanded with business rules
    IF <fs>-menge <= 0.
      <fs>-status = 'E'.   " Error
    ELSE.
      <fs>-status = 'V'.   " Valid
    ENDIF.
  ENDLOOP.
ENDFORM.

*&---------------------------------------------------------------------*
FORM build_field_catalog.
  CALL FUNCTION 'REUSE_ALV_FIELDCATALOG_MERGE'
    EXPORTING
      i_structure_name = 'TY_MOVEMENT'
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
      t_outtab           = gt_movement
    EXCEPTIONS
      OTHERS             = 1.

  IF sy-subrc <> 0.
    MESSAGE 'ALV Display Error' TYPE 'E'.
  ENDIF.
ENDFORM.
