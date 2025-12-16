
*&---------------------------------------------------------------------*

*&  Include           ZWORK03_001_SCR

*&---------------------------------------------------------------------*






SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME TITLE TEXT01.

  PARAMETERS : P_FILE TYPE RLGRAP-FILENAME.    "###(##)

  PARAMETERS : P_KURST TYPE KURST DEFAULT 'M' OBLIGATORY. "####

  SELECT-OPTIONS : S_ZGDATU FOR ZTCURR03-GDATU NO INTERVALS NO-EXTENSION. "####

SELECTION-SCREEN END OF BLOCK B1.



SELECTION-SCREEN PUSHBUTTON /1(25) BTN_TMPL USER-COMMAND TMPL. "#### ##

                                                               "/1(25) : 1# ####(/1)# ## 25# ## ##

                                                               "BTN_TMPL : ## ## ## ##

                                                               "## #### # 'TMPL' ### ##