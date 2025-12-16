
*&---------------------------------------------------------------------*

*&  Include           ZWORK08_001_SCR

*&---------------------------------------------------------------------*




" ### ## ##

SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME.

  " ####: ZTCURR08 #### ## ### ### ##

  PARAMETERS: P_ZGDATU TYPE ZTCURR08-GDATU OBLIGATORY,

              P_FILE TYPE RLGRAP-FILENAME OBLIGATORY MODIF ID M1.



SELECTION-SCREEN END OF BLOCK B1.



" ####: ## ## 'M'## ## & ## ###

PARAMETERS: P_KURST TYPE ZTCURR08-KURST OBLIGATORY DEFAULT 'M' MODIF ID FIX. " NO-DISPLAY.