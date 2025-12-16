
*&---------------------------------------------------------------------*

*&  Include           ZEDR04_084_SCR

*&---------------------------------------------------------------------*




SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME.

  SELECT-OPTIONS : S_ZCODE FOR ZEDT04_001-ZCODE.    " ## ## #### SELECT-OPTIONS#

  PARAMETERS : P_ZPERNR LIKE ZEDT04_001-ZPERNR.

  PARAMETERS : P_ZGEN LIKE ZEDT04_001-ZGENDER DEFAULT 'M' MODIF ID SC1.

SELECTION-SCREEN END OF BLOCK B1.