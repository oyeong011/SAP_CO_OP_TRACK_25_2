
*&---------------------------------------------------------------------*

*&  Include           ZWORK06_001_SCR

*&---------------------------------------------------------------------*








SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME.

  " ####

  PARAMETERS : P_DATE TYPE SY-DATUM DEFAULT SY-DATUM.

  " ## ##

  PARAMETERS : P_FILE TYPE RLGRAP-FILENAME DEFAULT 'C:\' MODIF ID M1.

  " ####

  PARAMETERS : P_KURST TYPE C LENGTH 2 DEFAULT 'M' MODIF ID M2.

SELECTION-SCREEN END OF BLOCK B1.