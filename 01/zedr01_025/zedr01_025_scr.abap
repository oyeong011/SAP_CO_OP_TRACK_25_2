
*&---------------------------------------------------------------------*

*&  Include           ZEDR01_025_SCR

*&---------------------------------------------------------------------*






SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME.

  SELECT-OPTIONS : S_ZCODE FOR ZEDT01_002-ZCODE.

  PARAMETERS : P_ZPERNR LIKE ZEDT01_002-ZPERNR.

SELECTION-SCREEN END OF BLOCK B1.



SELECTION-SCREEN BEGIN OF BLOCK B2 WITH FRAME.

  PARAMETERS : P_CH1 AS CHECKBOX DEFAULT 'X'.

SELECTION-SCREEN END OF BLOCK B2.