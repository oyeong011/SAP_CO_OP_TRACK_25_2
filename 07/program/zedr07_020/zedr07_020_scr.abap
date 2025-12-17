
*&---------------------------------------------------------------------*

*&  Include           ZEDR07_020_SCR

*&---------------------------------------------------------------------*




SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME.

  SELECT-OPTIONS : s_zcode FOR zedt07_001-zcode.

  PARAMETERS : p_zpernr LIKE zedt07_001-zpernr.

  PARAMETERS : p_zgen LIKE zedt07_001-zgender MODIF ID sc1.

SELECTION-SCREEN END OF BLOCK b1.






*&---------------------------------------------------------------------*

*&      Form  SET_SCREEN

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SET_SCREEN .



ENDFORM.