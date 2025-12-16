
*&---------------------------------------------------------------------*

*&  Include           ZMM15_004_SCR

*&---------------------------------------------------------------------*






SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME.

  PARAMETERS : P_EBELN TYPE EBELN . "####

  PARAMETERS : P_WERKS TYPE ZWERKS15 . "###

  PARAMETERS : P_BLDAT TYPE BLDAT MODIF ID M1. "#####

SELECTION-SCREEN END OF BLOCK B1.





SELECTION-SCREEN BEGIN OF BLOCK B2 WITH FRAME.

  "######

  PARAMETERS : P_R1 RADIOBUTTON GROUP G1 DEFAULT 'X' USER-COMMAND UC1.

  "######

  PARAMETERS : P_R2 RADIOBUTTON GROUP G1.

SELECTION-SCREEN END OF BLOCK B2.