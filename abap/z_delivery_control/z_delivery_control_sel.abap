*&---------------------------------------------------------------------*
*& Selection Screen for Z_DELIVERY_CONTROL
*&---------------------------------------------------------------------*

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.
SELECT-OPTIONS: s_vbeln FOR likp-vbeln,      " Delivery Number
                s_matnr FOR lips-matnr,      " Material
                s_werks FOR lips-werks.      " Plant
SELECTION-SCREEN END OF BLOCK b1.

SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME TITLE TEXT-002.
PARAMETERS: p_status TYPE char1 AS LISTBOX VISIBLE LENGTH 2 DEFAULT 'A', " A=All, P=Picked, C=Complete, E=Error
            p_late   TYPE char1 AS LISTBOX VISIBLE LENGTH 2 DEFAULT 'X'. " Show late deliveries
SELECTION-SCREEN END OF BLOCK b2.
