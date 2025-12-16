
*&---------------------------------------------------------------------*

*&  Include           ZWORK25_001_SCR

*&---------------------------------------------------------------------*




SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME TITLE TEXT-001.

 PARAMETERS: P_DATE  TYPE DATS,                       " ####

              P_FILE  TYPE RLGRAP-FILENAME, " ####

              P_KURST TYPE KURST_CURR DEFAULT 'M'.     " #### ## 'M'

SELECTION-SCREEN END OF BLOCK B1.



SELECTION-SCREEN FUNCTION KEY 1.  " ### #### ##