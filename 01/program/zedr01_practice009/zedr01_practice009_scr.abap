
*&---------------------------------------------------------------------*

*&  Include           ZEDR01_PRACTICE009_SCR

*&---------------------------------------------------------------------*






SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME.        "####

  SELECT-OPTIONS : S_ZPERNR FOR ZEDT01_102-ZPERNR.     "####

  PARAMETERS : S_DATE TYPE ZEDT01_102-DATAB.           "####

  PARAMETERS : S_ZCODE TYPE ZEDT01_102-ZDEPCODE.    "####

SELECTION-SCREEN END OF BLOCK B1.



SELECTION-SCREEN BEGIN OF BLOCK B2 WITH FRAME.        "####

  PARAMETERS : P_CH1 AS CHECKBOX.         "### ##

SELECTION-SCREEN END OF BLOCK B2.