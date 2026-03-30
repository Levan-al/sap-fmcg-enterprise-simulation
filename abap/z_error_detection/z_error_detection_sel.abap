*&---------------------------------------------------------------------*
*& Selection Screen for Z_ERROR_DETECTION
*&---------------------------------------------------------------------*

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.
SELECT-OPTIONS: s_matnr FOR mard-matnr,      " Material
                s_werks FOR mard-werks,      " Plant
                s_lgort FOR mard-lgort.      " Storage Location
SELECTION-SCREEN END OF BLOCK b1.

SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME TITLE TEXT-002.
PARAMETERS: p_neg   TYPE char1 AS LISTBOX VISIBLE LENGTH 2 DEFAULT 'X', " Show negative stock
            p_misf  TYPE char1 AS LISTBOX VISIBLE LENGTH 2 DEFAULT 'X', " Show MM-FI mismatches
            p_days  TYPE i DEFAULT 30.      " Check period in days
SELECTION-SCREEN END OF BLOCK b2.
