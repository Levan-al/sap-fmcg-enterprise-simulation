*&---------------------------------------------------------------------*
*& Report Z_MOVEMENT_CONTROL_TOP
*&---------------------------------------------------------------------*
*& Types and Global Data for Movement Control
*&---------------------------------------------------------------------*

REPORT z_movement_control_top.

TYPES: BEGIN OF ty_movement,
         mblnr TYPE mseg-mblnr,          " Material Document
         mjahr TYPE mseg-mjahr,
         zeile TYPE mseg-zeile,
         matnr TYPE mseg-matnr,
         maktx TYPE makt-maktx,
         werks TYPE mseg-werks,
         lgort TYPE mseg-lgort,
         bwart TYPE mseg-bwart,          " Movement Type
         btext TYPE t156t-btext,         " Movement Type Text
         menge TYPE mseg-menge,
         meins TYPE mseg-meins,
         budat TYPE mkpf-budat,
         usnam TYPE mkpf-usnam,
         status TYPE char1,              " Custom status (V = Valid, E = Error)
       END OF ty_movement.

TYPES: tt_movement TYPE STANDARD TABLE OF ty_movement WITH EMPTY KEY.

DATA: gt_movement   TYPE tt_movement,
      gt_fieldcat   TYPE slis_t_fieldcat_alv,
      gs_layout     TYPE slis_layout_alv.
