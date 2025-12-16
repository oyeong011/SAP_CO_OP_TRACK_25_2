
*&---------------------------------------------------------------------*

*&  Include           ZWORK02_001_SCR

*&---------------------------------------------------------------------*




SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME.

  PARAMETERS : P_DATE TYPE D DEFAULT SY-DATUM. "####

  PARAMETERS: P_FILE TYPE RLGRAP-FILENAME. "###(##)

  PARAMETERS : P_KURST TYPE KURST DEFAULT 'M' MODIF ID M1 VISIBLE LENGTH 1. "####(M## ##)

SELECTION-SCREEN END OF BLOCK B1.