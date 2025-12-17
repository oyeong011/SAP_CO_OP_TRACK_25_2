
*&---------------------------------------------------------------------*

*&  Include           ZEDR02_028_SCR

*&---------------------------------------------------------------------*




SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME.

  SELECT-OPTIONS : S_ZCODE FOR ZEDT02_001-ZCODE.

  PARAMETERS: P_ZPERNR LIKE ZEDT02_001-ZPERNR.

  PARAMETERS : P_ZGEN LIKE ZEDT02_001-ZGENDER MODIF ID SC1.

SELECTION-SCREEN END OF BLOCK B1.