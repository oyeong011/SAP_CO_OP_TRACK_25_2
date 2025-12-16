
*&---------------------------------------------------------------------*

*&  Include           ZMM03_004_SCR

*&---------------------------------------------------------------------*



* ## ##




SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME TITLE TEXT-001.

  PARAMETERS: P_EBELN TYPE ZEDT03_EKKO-EBELN, " ####

              P_WERKS TYPE ZEDT03_EKPO-WERK. " ###

  " ## ### (## ## #####)

  PARAMETERS: P_IVDAT TYPE ZEDT03_RBKP-BLDAT DEFAULT SY-DATUM MODIF ID M1. "### ### ###

SELECTION-SCREEN END OF BLOCK B1.






*## ##




SELECTION-SCREEN BEGIN OF BLOCK B2 WITH FRAME TITLE TEXT-002.

  PARAMETERS: P_R1 RADIOBUTTON GROUP G1 DEFAULT 'X' USER-COMMAND UC1, "## ##

              P_R2 RADIOBUTTON GROUP G1.                              "## ##

SELECTION-SCREEN END OF BLOCK B2.