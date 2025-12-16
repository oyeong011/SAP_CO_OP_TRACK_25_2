
*&---------------------------------------------------------------------*

*&  Include           ZEDT20_030_SCR

*&---------------------------------------------------------------------*




SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME.

  SELECT-OPTIONS: S_ZCODE FOR ZEDT20_001-ZCODE.

  PARAMETERS: P_ZPERNR LIKE ZEDT20_001-ZPERNR.

SELECTION-SCREEN END OF BLOCK B1.