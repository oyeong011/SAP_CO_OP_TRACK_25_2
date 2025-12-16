
*&---------------------------------------------------------------------*

*&  Include           ZWORK22_001_SCR

*&---------------------------------------------------------------------*






SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME.

PARAMETERS: P_FILE  TYPE RLGRAP-FILENAME.    " ###

PARAMETERS: P_DATE  TYPE SY-DATUM.  " ####

PARAMETERS: P_KURST TYPE KURST_CURR DEFAULT 'M' OBLIGATORY. " #### (M ##)

SELECTION-SCREEN END OF BLOCK B1.