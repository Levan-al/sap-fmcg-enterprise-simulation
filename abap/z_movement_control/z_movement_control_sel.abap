*&---------------------------------------------------------------------*
*& Selection Screen for Z_MOVEMENT_CONTROL
*&---------------------------------------------------------------------*

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.
SELECT-OPTIONS: s_matnr FOR mseg-matnr,      " Material
                s_werks FOR mseg-werks,      " Plant
                s_lgort FOR mseg-lgort,      " Storage Location
                s_bwart FOR mseg-bwart.      " Movement Type
SELECTION-SCREEN END OF BLOCK b1.

SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME TITLE TEXT-002.
PARAMETERS: p_date  TYPE mkpf-budat OBLIGATORY DEFAULT sy-datum,
            p_user  TYPE mkpf-usnam,
            p_valid TYPE char1 AS LISTBOX VISIBLE LENGTH 2 DEFAULT 'A'. " A=All, V=Valid, E=Error
SELECTION-SCREEN END OF BLOCK b2.
