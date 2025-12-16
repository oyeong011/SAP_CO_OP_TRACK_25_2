
*&---------------------------------------------------------------------*

*&  Include           ZMM12_002_SCR

*&---------------------------------------------------------------------*




SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME.

  PARAMETERS P_BUKRS LIKE ZLFB1_12-BUKRS. "####

  PARAMETERS P_LIFNR1 TYPE LIFNR MODIF ID M1.         "###

  PARAMETERS P_BEDAT LIKE ZEKKO_12-BEDAT MODIF ID M1. "###



  PARAMETERS P_LIFNR2 TYPE LIFNR MODIF ID M2.         "###

  PARAMETERS P_EBELN TYPE EBELN MODIF ID M2.          "PO##



  PARAMETERS P_RD1 RADIOBUTTON GROUP R1 DEFAULT 'X' USER-COMMAND UC1. "##

  PARAMETERS P_RD2 RADIOBUTTON GROUP R1. "##

SELECTION-SCREEN END OF BLOCK B1.