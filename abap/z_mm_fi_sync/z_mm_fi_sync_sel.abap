*&---------------------------------------------------------------------*
*& Selection Screen for Z_MM_FI_SYNC
*&---------------------------------------------------------------------*

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.
SELECT-OPTIONS: s_matnr FOR mseg-matnr,      " Material
                s_werks FOR mseg-werks,      " Plant
                s_belnr FOR bkpf-belnr.      " FI Document (optional)
SELECTION-SCREEN END OF BLOCK b1.

SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME TITLE TEXT-002.
PARAMETERS: p_days   TYPE i DEFAULT 30,       " Check last N days
            p_showmm TYPE char1 AS LISTBOX VISIBLE LENGTH 2 DEFAULT 'X', " Show MM-FI mismatches
            p_shown  TYPE char1 AS LISTBOX VISIBLE LENGTH 2 DEFAULT 'X'. " Show negative stock issues
SELECTION-SCREEN END OF BLOCK b2.
