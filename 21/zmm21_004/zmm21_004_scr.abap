
*&---------------------------------------------------------------------*

*&  Include           ZMM21_004_SCR

*&---------------------------------------------------------------------*




SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME.

  PARAMETERS : P_EBELN TYPE EBELN.

  PARAMETERS : P_WERKS TYPE ZWERKS21.

  PARAMETERS : P_DATE TYPE SY-DATUM MODIF ID M1.

  SELECTION-SCREEN END OF BLOCK B1.





SELECTION-SCREEN BEGIN OF BLOCK B2 WITH FRAME.

   PARAMETERS : p_rad1 RADIOBUTTON GROUP rb1 DEFAULT 'X' USER-COMMAND uc1. "####

   PARAMETERS : p_rad2 RADIOBUTTON GROUP rb1.

  SELECTION-SCREEN END OF BLOCK B2.