*&---------------------------------------------------------------------*
*& Report Z_DELIVERY_CONTROL
*&---------------------------------------------------------------------*
*& Delivery Control and Monitoring Report (SD-WM Integration)
*&---------------------------------------------------------------------*

REPORT z_delivery_control.

INCLUDE z_delivery_control_top.
INCLUDE z_delivery_control_sel.

START-OF-SELECTION.

  PERFORM authority_check.
  PERFORM fetch_delivery_data.
  PERFORM analyze_deliveries.
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
FORM fetch_delivery_data.
  SELECT 
    l~vbeln,
    p~posnr,
    p~matnr,
    k~maktx,
    p~werks,
    p~lgort,
    p~lfimg,
    p~vrkme,
    l~vbtyp,
    l~erdat
  FROM likp AS l
  INNER JOIN lips AS p ON p~vbeln = l~vbeln
  LEFT JOIN makt AS k ON k~matnr = p~matnr AND k~spras = sy-langu
  INTO TABLE @gt_delivery
  WHERE l~vbeln IN @s_vbeln
    AND p~matnr IN @s_matnr
    AND p~werks IN @s_werks.
ENDFORM.

*&---------------------------------------------------------------------*
FORM analyze_deliveries.
  LOOP AT gt_delivery ASSIGNING FIELD-SYMBOL(<fs>).
    " Simple status logic - can be enhanced with actual picking/packing status
    IF <fs>-lfimg > 0.
      <fs>-status = 'C'.   " Complete
    ELSE.
      <fs>-status = 'P'.   " Pending
    ENDIF.

    " Late delivery check (example: if creation date is older than 5 days)
    IF <fs>-erdat < sy-datum - 5.
      <fs>-status = 'E'.   " Error / Late
      <fs>-message = 'Late delivery detected'.
    ENDIF.
  ENDLOOP.
ENDFORM.

*&---------------------------------------------------------------------*
FORM build_field_catalog.
  CALL FUNCTION 'REUSE_ALV_FIELDCATALOG_MERGE'
    EXPORTING
      i_structure_name = 'TY_DELIVERY'
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
      t_outtab           = gt_delivery.
ENDFORM.
