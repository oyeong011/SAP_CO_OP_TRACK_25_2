
*&---------------------------------------------------------------------*

*&  Include           ZWORK20_001_SCR

*&---------------------------------------------------------------------*




SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME.

  SELECT-OPTIONS: S_DATE FOR SY-DATUM NO INTERVALS NO-EXTENSION.

  PARAMETERS: P_FNAME TYPE RLGRAP-FILENAME.

  PARAMETERS: P_TYPE(1) .

SELECTION-SCREEN END OF BLOCK B1.