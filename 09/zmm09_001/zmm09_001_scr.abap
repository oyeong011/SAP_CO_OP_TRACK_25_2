
*&---------------------------------------------------------------------*

*&  Include           ZMM09_001_SCR

*&---------------------------------------------------------------------*






SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME.

  "### ## - ####, ####

  PARAMETERS : P_BUKR_C LIKE ZLFB1_09-BUKRS MODIF ID C.  "####

  PARAMETERS : P_KTOKK LIKE ZLFA1_09-KTOKK MODIF ID C.  "#####



  "### ##

  PARAMETERS : P_LIFNR LIKE ZLFA1_09-LIFNR MODIF ID S.  "#####

  PARAMETERS : P_BUKR_S LIKE ZLFB1_09-BUKRS MODIF ID S. "####



  SELECTION-SCREEN SKIP.



  "##/## ##

  PARAMETERS : P_R1 RADIOBUTTON GROUP R1 DEFAULT 'X' USER-COMMAND UC1. "##

  PARAMETERS : P_R2 RADIOBUTTON GROUP R1.             "##

SELECTION-SCREEN END OF BLOCK B1.