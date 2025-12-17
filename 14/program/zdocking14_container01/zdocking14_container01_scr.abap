
*&---------------------------------------------------------------------*

*&  Include           ZDOCKING14_CONTAINER01_SCR

*&---------------------------------------------------------------------*






SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME.

  SELECT-OPTIONS : S_ZCODE FOR ZEDT14_002-ZCODE.

  PARAMETERS: P_ZPERNR LIKE ZEDT14_002-ZPERNR.




*  PARAMETERS : P_ZGEN LIKE ZEDT14_002-ZGENDER MODIF ID SC1.




SELECTION-SCREEN END OF BLOCK B1.