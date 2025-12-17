
*&---------------------------------------------------------------------*

*&  Include  ZCUSTOM_CONTAINER21_SCR

*&---------------------------------------------------------------------*




SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME.

  SELECT-OPTIONS : s_zcode FOR zedt21_001-zcode21.

  PARAMETERS : p_zpernr LIKE zedt21_001-zpernr21.

  PARAMETERS : p_zgen LIKE zedt21_001-zgubun21 MODIF ID sc1.

SELECTION-SCREEN END OF BLOCK b1.





FORM SET_SCREEN.



  ENDFORM.