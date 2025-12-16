
*&---------------------------------------------------------------------*

*&  Include           ZMM22_004_SCR

*&---------------------------------------------------------------------*




SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME.



  " ## ##

  PARAMETERS : P_EBELN LIKE ZRBKP_22-EBELN MODIF ID C. " ####

  PARAMETERS : P_WERKS LIKE ZRBKP_22-WERKS MODIF ID C. " ###

  PARAMETERS : P_DATE  LIKE SY-DATUM MODIF ID C. " #####



  " ## ##

  PARAMETERS : P_EBELN2 LIKE ZRBKP_22-EBELN MODIF ID S. " ####

  PARAMETERS : P_WERKS2 LIKE ZRBKP_22-WERKS MODIF ID S. " ###



  SELECTION-SCREEN SKIP.



  " [### ##] ## ##

  PARAMETERS : P_R1 RADIOBUTTON GROUP R1 DEFAULT 'X' USER-COMMAND UC1. " ####

  PARAMETERS : P_R2 RADIOBUTTON GROUP R1.                              " ####



SELECTION-SCREEN END OF BLOCK B1.