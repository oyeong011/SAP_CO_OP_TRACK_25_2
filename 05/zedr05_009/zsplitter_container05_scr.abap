
*&---------------------------------------------------------------------*

*&  Include           ZSPLITTER_CONTAINER05_SCR

*&---------------------------------------------------------------------*








SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME.

  SELECT-OPTIONS S_ZCODE FOR ZEDT05_001-ZCODE.



  PARAMETERS : P_ZPERNR LIKE ZEDT05_001-ZPERNR,

               P_ZGEN LIKE ZEDT05_001-ZGENDER MODIF ID SC1.

SELECTION-SCREEN END OF BLOCK B1.