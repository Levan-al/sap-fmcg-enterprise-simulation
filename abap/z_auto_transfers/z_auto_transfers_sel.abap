*&---------------------------------------------------------------------*
*& Selection Screen for Z_AUTO_TRANSFERS
*&---------------------------------------------------------------------*

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.
SELECT-OPTIONS: s_matnr FOR mard-matnr,      " Material
                s_werks FOR mard-werks,      " Plant
                s_lgort FOR mard-lgort.      " Storage Location
SELECTION-SCREEN END OF BLOCK b1.

SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME TITLE TEXT-002.
PARAMETERS: p_minqty TYPE mard-speme DEFAULT '10',   " Minimum blocked qty to transfer
            p_test   TYPE char1 AS LISTBOX VISIBLE LENGTH 2 DEFAULT 'X', " X = Test mode, ' ' = Real posting
            p_bwart  TYPE bapi2017_gm_item-bwart DEFAULT '321'. " Default movement type for transfer
SELECTION-SCREEN END OF BLOCK b2.
