
*&---------------------------------------------------------------------*

*&  Include           ZMM09_003_SCR

*&---------------------------------------------------------------------*






SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME.

  "##

  PARAMETERS : P_EBELNC LIKE ZEKKO_09-EBELN MODIF ID C. "####

  PARAMETERS : P_WERKSC LIKE ZMSEG09-WERKS MODIF ID C. "###

  PARAMETERS : P_BUDAT LIKE ZMKPF09-BUDAT MODIF ID C. "#####



  "##

  PARAMETERS : P_EBELNS LIKE ZEKKO_09-EBELN MODIF ID S. "####

  PARAMETERS : P_WERKSS LIKE ZMSEG09-WERKS MODIF ID S. "###



  SELECTION-SCREEN SKIP.



  "##/## ##

  PARAMETERS : P_R1 RADIOBUTTON GROUP R1 DEFAULT 'X' USER-COMMAND UC1. "####

  PARAMETERS : P_R2 RADIOBUTTON GROUP R1.             "####

SELECTION-SCREEN END OF BLOCK B1.