
SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME.

  SELECT-OPTIONS : s_zcode FOR zedt07_001-zcode.

  parameters : p_zpernr like zedt07_001-zpernr.

  PARAMETERS : p_zgen LIKE zedt07_001-zgender MODIF ID sc1.

SELECTION-SCREEN END OF BLOCK b1.





FORM SET_SCREEN.



  ENDFORM.