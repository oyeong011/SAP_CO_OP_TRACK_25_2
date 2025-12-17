
*&---------------------------------------------------------------------*

*&  Include           ZMM12_003_SCR

*&---------------------------------------------------------------------*




SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME.

  PARAMETERS : P1 TYPE EBELN.             "PO ##

  PARAMETERS : P2 TYPE WERKS.             "###

  PARAMETERS : P3 TYPE BUDAT MODIF ID M1. "#####(=###) ######. ### ###



  SELECTION-SCREEN BEGIN OF LINE.

  PARAMETERS P_RD1 RADIOBUTTON GROUP R1 DEFAULT 'X' USER-COMMAND UC1. "####

  SELECTION-SCREEN COMMENT 15(6) FOR FIELD P_RD1.

  PARAMETERS P_RD2 RADIOBUTTON GROUP R1.                               "####

  SELECTION-SCREEN COMMENT 35(6) FOR FIELD P_RD2.

  SELECTION-SCREEN END OF LINE.



SELECTION-SCREEN END OF BLOCK B1.