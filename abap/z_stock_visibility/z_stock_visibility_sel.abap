*&---------------------------------------------------------------------*
*& Selection Screen for Z_STOCK_VISIBILITY
*&---------------------------------------------------------------------*

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.
SELECT-OPTIONS: s_matnr FOR mara-matnr,      " Material
                s_werks FOR mard-werks,      " Plant
                s_lgort FOR mard-lgort.      " Storage Location
SELECTION-SCREEN END OF BLOCK b1.

SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME TITLE TEXT-002.
PARAMETERS: p_batch TYPE mard-charg,         " Batch (optional)
            p_show  TYPE char1 AS LISTBOX VISIBLE LENGTH 2 DEFAULT 'A'. " A=All, U=Unrestricted
SELECTION-SCREEN END OF BLOCK b2.
