
*&---------------------------------------------------------------------*

*&  Include           ZEDR24_PRACTICE009_SCR

*&---------------------------------------------------------------------*






"1. ## ## ##

"1-1. ####, ##, ##

SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME.

  "1-1-1. ## ####

  SELECT-OPTIONS S_ZPERNR FOR ZEDT24_102-ZPERNR.                 "#### ( ~ )



  "1-1-2. ####

  SELECT-OPTIONS S_TERM FOR ZEDT24_102-ZEDATE NO INTERVALS NO-EXTENSION.       "## ( ~ )



  "1-1-3. ####

  SELECT-OPTIONS S_ZDCODE FOR ZEDT24_102-ZDEPCODE NO INTERVALS NO-EXTENSION.   "##

SELECTION-SCREEN END OF BLOCK B1.



"1-2. ### ##

SELECTION-SCREEN BEGIN OF BLOCK B2 WITH FRAME.

  PARAMETERS : P_ISQUIT AS CHECKBOX.   "#### (#### ###)

SELECTION-SCREEN END OF BLOCK B2.