
*&---------------------------------------------------------------------*

*&  Include           ZEDR09_035_SCR

*&---------------------------------------------------------------------*






SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME.

  SELECT-OPTIONS : S_ZCODE FOR ZEDT09_001-ZCODE.

  PARAMETERS : P_ZPERNR LIKE ZEDT09_001-ZPERNR.

  PARAMETERS : P_ZGEN LIKE ZEDT09_001-ZGENDER MODIF ID SC1.

SELECTION-SCREEN END OF BLOCK b1.