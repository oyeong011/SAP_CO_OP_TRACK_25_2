
*&---------------------------------------------------------------------*

*&  Include  ZEDR11_014_SCR

*&---------------------------------------------------------------------*




SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME.

  SELECT-OPTIONS : s_zcode FOR zedt11_001-zcode.

  PARAMETERS : p_zpernr LIKE zedt11_001-zpernr.

  PARAMETERS : p_zgen LIKE zedt11_001-zgender MODIF ID sc1.

SELECTION-SCREEN END OF BLOCK b1.