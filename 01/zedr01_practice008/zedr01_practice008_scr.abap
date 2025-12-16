
*&---------------------------------------------------------------------*

*&  Include           ZEDR01_PRACTICE008_SCR

*&---------------------------------------------------------------------*






SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME.                " ### ##

  SELECT-OPTIONS : S_ZORDNO FOR ZEDT01_100-ZORDNO.            " ####

  PARAMETERS : S_ZCODE LIKE ZEDT01_100-ZIDCODE.               " ##ID

  SELECT-OPTIONS : S_ZMATNR FOR ZEDT01_100-ZMATNR.            " ####

  SELECT-OPTIONS : S_ZJDATE FOR ZEDT01_100-ZJDATE MODIF ID M1." #### ( M1 )

  SELECT-OPTIONS : S_ZDDATE FOR ZEDT01_101-ZDDATE MODIF ID M2." #### ( M2 )

SELECTION-SCREEN END OF BLOCK B1.



SELECTION-SCREEN BEGIN OF BLOCK B2 WITH FRAME.                         " ### ## ##

  PARAMETERS : P_R1 RADIOBUTTON GROUP R1 DEFAULT 'X' USER-COMMAND UC1. " #### ### ## ( R1 )

  PARAMETERS : P_R2 RADIOBUTTON GROUP R1.                              " #### ### ## ( R1 )

SELECTION-SCREEN END OF BLOCK B2.



SELECTION-SCREEN BEGIN OF BLOCK B3 WITH FRAME.                         " ## ## ##

  PARAMETERS : P_CH1 AS CHECKBOX DEFAULT 'X'.                          " #### ## ##

SELECTION-SCREEN END OF BLOCK B3.