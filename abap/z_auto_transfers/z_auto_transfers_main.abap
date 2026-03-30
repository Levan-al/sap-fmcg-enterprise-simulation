*&---------------------------------------------------------------------*
*& Report Z_AUTO_TRANSFERS
*&---------------------------------------------------------------------*
*& Automatic Transfer from Blocked to Unrestricted Stock
*&---------------------------------------------------------------------*

REPORT z_auto_transfers.

INCLUDE z_auto_transfers_top.
INCLUDE z_auto_transfers_sel.

START-OF-SELECTION.

  PERFORM authority_check.
  PERFORM select_blocked_stock.
  PERFORM process_transfers.
  PERFORM display_results.

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
FORM select_blocked_stock.
  SELECT 
    d~matnr,
    k~maktx,
    d~werks,
    d~lgort,
    d~charg,
    d~speme AS blocked,
    d~labst AS unrestricted
  FROM mard AS d
  LEFT JOIN makt AS k ON k~matnr = d~matnr AND k~spras = sy-langu
  INTO TABLE @gt_transfer
  WHERE d~matnr IN @s_matnr
    AND d~werks IN @s_werks
    AND d~lgort IN @s_lgort
    AND d~speme >= @p_minqty.
ENDFORM.

*&---------------------------------------------------------------------*
FORM process_transfers.
  LOOP AT gt_transfer ASSIGNING FIELD-SYMBOL(<fs>).
    IF p_test = 'X'.
      <fs>-status = 'S'.
      <fs>-message = 'Test mode - no posting'.
      CONTINUE.
    ENDIF.

    PERFORM post_transfer USING <fs> CHANGING <fs>-status <fs>-message.
  ENDLOOP.
ENDFORM.

*&---------------------------------------------------------------------*
FORM post_transfer USING ls_transfer TYPE ty_transfer
                   CHANGING cv_status TYPE char1
                            cv_message TYPE bapi_msg.

  DATA: ls_header TYPE bapi2017_gm_head_01,
        lt_item   TYPE TABLE OF bapi2017_gm_item_create,
        ls_item   TYPE bapi2017_gm_item_create,
        lv_mblnr  TYPE bapi2017_gm_head_ret-mat_doc,
        lv_mjahr  TYPE bapi2017_gm_head_ret-doc_year.

  ls_header-pstng_date = sy-datum.
  ls_header-doc_date   = sy-datum.

  ls_item-material     = ls_transfer-matnr.
  ls_item-plant        = ls_transfer-werks.
  ls_item-stge_loc     = ls_transfer-lgort.
  ls_item-batch        = ls_transfer-charg.
  ls_item-move_type    = p_bwart.
  ls_item-entry_qnt    = ls_transfer-blocked.
  ls_item-entry_uom    = 'EA'.

  APPEND ls_item TO lt_item.

  CALL FUNCTION 'BAPI_GOODSMVT_CREATE'
    EXPORTING
      goodsmvt_header  = ls_header
      goodsmvt_code    = '04'   " Transfer posting
    IMPORTING
      materialdocument = lv_mblnr
      matdocumentyear  = lv_mjahr
    TABLES
      goodsmvt_item    = lt_item
      return           = gv_bapi_return.

  IF line_exists( gv_bapi_return[ type = 'E' ] ).
    cv_status = 'E'.
    cv_message = gv_bapi_return[ 1 ]-message.
  ELSE.
    cv_status = 'S'.
    cv_message = |Document { lv_mblnr } posted successfully|.
    COMMIT WORK AND WAIT.
  ENDIF.
ENDFORM.

*&---------------------------------------------------------------------*
FORM display_results.
  PERFORM build_field_catalog.
  PERFORM display_alv.
ENDFORM.

*&---------------------------------------------------------------------*
FORM build_field_catalog.
  CALL FUNCTION 'REUSE_ALV_FIELDCATALOG_MERGE'
    EXPORTING
      i_structure_name = 'TY_TRANSFER'
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
      t_outtab           = gt_transfer.
ENDFORM.
