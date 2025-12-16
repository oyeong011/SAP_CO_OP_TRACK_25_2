
*&---------------------------------------------------------------------*

*&  Include           ZCUSTOM_CONTAINER_SCR_25_2

*&---------------------------------------------------------------------*




SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME.

SELECT-OPTIONS : S_ZCODE FOR ZEDT25_001-ZCODE.

PARAMETERS : P_ZPERNR LIKE ZEDT25_001-ZPERNR.

PARAMETERS : P_ZGEN LIKE ZEDT25_001-ZGENDER MODIF ID SC1.

SELECTION-SCREEN END OF BLOCK B1.