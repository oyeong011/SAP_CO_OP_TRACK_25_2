
*&---------------------------------------------------------------------*

*&  Include           ZMM12_004_SCR

*&---------------------------------------------------------------------*




SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME.

  "1. ### ## ##

  PARAMETERS : P_EBELN LIKE ZEKKO_12-EBELN.  "####

  PARAMETERS : P_WERKS LIKE ZRSEG_12-WERKS. "###

  PARAMETERS : P_DATE LIKE SY-DATUM MODIF ID M1. "#####



  "2. ## OR ## ##

  PARAMETERS : P_RD1 RADIOBUTTON GROUP R1 DEFAULT 'X' USER-COMMAND UCOM. "##

  PARAMETERS : P_RD2 RADIOBUTTON GROUP R1. "##

SELECTION-SCREEN END OF BLOCK B1.