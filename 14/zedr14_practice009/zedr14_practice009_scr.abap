
*&---------------------------------------------------------------------*

*&  Include           ZEDR14_PRACTICE009_SCR

*&---------------------------------------------------------------------*






SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME.

  SELECT-OPTIONS : S_ZPERNR FOR ZEDT14_102-ZPERNR.       "####

  PARAMETERS : P_ZDATE LIKE ZEDT14_102-ZEDATE.           "####

  SELECT-OPTIONS : S_ZDEPCO FOR ZEDT14_102-ZDEPCODE NO INTERVALS NO-EXTENSION..        "####

SELECTION-SCREEN END OF BLOCK B1.

SELECTION-SCREEN BEGIN OF BLOCK B2 WITH FRAME.

  PARAMETERS : P_CH1 AS CHECKBOX.  "#####

SELECTION-SCREEN END OF BLOCK B2.