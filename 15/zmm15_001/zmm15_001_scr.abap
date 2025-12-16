
*&---------------------------------------------------------------------*

*&  Include           ZMM15_001_SCR

*&---------------------------------------------------------------------*






SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME.

  PARAMETERS : P_KTOKK TYPE ZLFA1_15-KTOKK MODIF ID M1. "##### (##)

  PARAMETERS : P_BUKRS TYPE ZLFB1_15-BUKRS.             "####   (##, ##)

  PARAMETERS : P_LIFNR TYPE LIFNR MODIF ID M2. "##### (##)

SELECTION-SCREEN END OF BLOCK B1.





SELECTION-SCREEN BEGIN OF BLOCK B2 WITH FRAME.

  "####

  PARAMETERS : P_R1 RADIOBUTTON GROUP G1 DEFAULT 'X' USER-COMMAND UC1.

  "####

  PARAMETERS : P_R2 RADIOBUTTON GROUP G1.

SELECTION-SCREEN END OF BLOCK B2.