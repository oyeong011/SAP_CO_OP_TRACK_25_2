
*&---------------------------------------------------------------------*

*&  Include  ZEDR19_052_SCR

*&---------------------------------------------------------------------*






SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME.

  SELECT-OPTIONS : S_ZCODE FOR ZEDT19_0001-ZCODE.

  PARAMETERS : P_ZERNR LIKE ZEDT19_0001-ZPERNR.

  PARAMETERS : P_ZGEN LIKE ZEDT19_0001-ZGENDER MODIF ID SC1.

SELECTION-SCREEN END OF BLOCK B1.