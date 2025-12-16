
*&---------------------------------------------------------------------*

*&  Include           ZCUSTUM_CONTAINER11_SCR

*&---------------------------------------------------------------------*






SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME.

  SELECT-OPTIONS : S_ZPERNR FOR ZEDT11_001-ZPERNR.

  PARAMETERS : P_ZGEN LIKE ZEDT11_001-ZGENDER MODIF ID SCL.

  SELECTION-SCREEN END OF BLOCK B1.



  FORM SET_SCREEN .



ENDFORM.