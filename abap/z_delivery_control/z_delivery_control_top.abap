*&---------------------------------------------------------------------*
*& Report Z_DELIVERY_CONTROL_TOP
*&---------------------------------------------------------------------*
*& Types and Global Data for Delivery Control
*&---------------------------------------------------------------------*

REPORT z_delivery_control_top.

TYPES: BEGIN OF ty_delivery,
         vbeln TYPE likp-vbeln,          " Delivery Number
         posnr TYPE lips-posnr,
         matnr TYPE lips-matnr,
         maktx TYPE makt-maktx,
         werks TYPE lips-werks,
         lgort TYPE lips-lgort,
         lfimg TYPE lips-lfimg,          " Delivery Quantity
         vrkme TYPE lips-vrkme,
         vbtyp TYPE likp-vbtyp,
         status TYPE char1,              " P = Picked, C = Complete, E = Error
         message TYPE bapi_msg,
       END OF ty_delivery.

TYPES: tt_delivery TYPE STANDARD TABLE OF ty_delivery WITH EMPTY KEY.

DATA: gt_delivery   TYPE tt_delivery,
      gt_fieldcat   TYPE slis_t_fieldcat_alv,
      gs_layout     TYPE slis_layout_alv.
