
*&---------------------------------------------------------------------*

*&  Include           ZMM09_002_SCR

*&---------------------------------------------------------------------*






SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME.

  "##

  PARAMETERS : P_BUKR_C LIKE ZEKKO_09-BUKRS MODIF ID C. "####

  PARAMETERS : P_LIFN_C LIKE ZEKKO_09-LIFNR MODIF ID C. "###

  PARAMETERS : P_BEDAT TYPE DATS MODIF ID C. "###



  "##

  PARAMETERS : P_LIFN_S LIKE ZEKKO_09-LIFNR MODIF ID S. "###

  PARAMETERS : P_BUKR_S LIKE ZEKKO_09-BUKRS MODIF ID S. "####

  PARAMETERS : P_EBELN LIKE ZEKKO_09-EBELN MODIF ID S. "PO##



  SELECTION-SCREEN SKIP.



  "##/## ##

  PARAMETERS : P_R1 RADIOBUTTON GROUP R1 DEFAULT 'X' USER-COMMAND UC1. "##

  PARAMETERS : P_R2 RADIOBUTTON GROUP R1.             "##

SELECTION-SCREEN END OF BLOCK B1.