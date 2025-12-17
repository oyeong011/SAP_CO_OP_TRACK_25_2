
*&---------------------------------------------------------------------*

*&  Include           ZWORK24_001_SCR

*&---------------------------------------------------------------------*






SELECTION-SCREEN FUNCTION KEY 1. "SCREEN# TOOLBAR# ## ##



SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME.

  "####

  PARAMETERS : PA_DATE TYPE SY-DATUM.



  "####

  SELECT-OPTIONS S_KURST FOR ZTCURR24-KURST NO INTERVALS NO-EXTENSION.



  "## ## ##

  PARAMETERS : PA_FILE TYPE RLGRAP-FILENAME MODIF ID FUP.

SELECTION-SCREEN END OF BLOCK B1.