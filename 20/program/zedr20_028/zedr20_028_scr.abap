
*&---------------------------------------------------------------------*

*&  Include           ZEDR20_028_SCR

*&---------------------------------------------------------------------*




SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME.

  SELECT-OPTIONS: S_ZCODE FOR ZEDT20_002-ZCODE.

  PARAMETERS: P_ZPERNR LIKE ZEDT20_002-ZPERNR.

SELECTION-SCREEN END OF BLOCK B1.