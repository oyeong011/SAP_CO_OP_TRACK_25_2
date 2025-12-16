
*&---------------------------------------------------------------------*

*&  Include           ZEDR12_PRACTICE009_SCR

*&---------------------------------------------------------------------*






" SELECTION-SCREEN

SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME.

 SELECT-OPTIONS: S_ZPERNR FOR ZEDT12_102-ZPERNR.                             "####

 SELECT-OPTIONS: S_ZDATE  FOR ZEDT12_102-DATBI   NO INTERVALS NO-EXTENSION.  " ####

 SELECT-OPTIONS: S_ZDCODE FOR ZEDT12_102-ZDEPCODE NO INTERVALS NO-EXTENSION.  " ####

SELECTION-SCREEN END OF BLOCK B1.



SELECTION-SCREEN BEGIN OF BLOCK B2 WITH FRAME.

  PARAMETERS P_ZQFLAG AS CHECKBOX.                                           "#####.

SELECTION-SCREEN END OF BLOCK B2.