
*&---------------------------------------------------------------------*

*&  Include           ZCUSTON_CONTAINER19_SCR

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Form  SET_SCREEN

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM set_screen.



ENDFORM.



SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME.

  SELECT-OPTIONS : S_ZCODE FOR ZEDT19_0001-ZCODE.

  PARAMETERS : P_ZERNR LIKE ZEDT19_0001-ZPERNR.

  PARAMETERS : P_ZGEN LIKE ZEDT19_0001-ZGENDER MODIF ID SC1.

SELECTION-SCREEN END OF BLOCK B1.