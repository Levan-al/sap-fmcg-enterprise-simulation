*&---------------------------------------------------------------------*
*& Selection Screen for Z_WAREHOUSE_ANALYTICS
*&---------------------------------------------------------------------*

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.
SELECT-OPTIONS: s_matnr FOR mard-matnr,      " Material
                s_werks FOR mard-werks,      " Plant
                s_lgort FOR mard-lgort.      " Storage Location
SELECTION-SCREEN END OF BLOCK b1.

SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME TITLE TEXT-002.
PARAMETERS: p_days   TYPE i DEFAULT 90,       " Days for slow/dead stock calculation
            p_abc    TYPE char1 AS LISTBOX VISIBLE LENGTH 2 DEFAULT 'A', " A/B/C filter
            p_detail TYPE char1 AS LISTBOX VISIBLE LENGTH 2 DEFAULT 'X'. " X = Detailed, ' ' = Summary
SELECTION-SCREEN END OF BLOCK b2.
