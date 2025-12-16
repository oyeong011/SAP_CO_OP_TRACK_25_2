
*&---------------------------------------------------------------------*

*&  Include           ZEDR11_PRACTICE008_SCR

*&---------------------------------------------------------------------*




SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME.

  SELECT-OPTIONS: s_zordno FOR zedt11_100-zordno.

  SELECT-OPTIONS: s_zid    FOR zedt11_100-zidcode NO INTERVALS NO-EXTENSION.

  SELECT-OPTIONS: s_zmatnr FOR zedt11_100-zmatnr.

  SELECT-OPTIONS: s_zjdate FOR zedt11_100-zjdate MODIF ID m1.

  SELECT-OPTIONS: s_zddate FOR zedt11_101-zddate MODIF ID m2.

SELECTION-SCREEN END OF BLOCK b1.



SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME.

  PARAMETERS: p_r1 RADIOBUTTON GROUP r1 DEFAULT 'X' USER-COMMAND uc1,

              p_r2 RADIOBUTTON GROUP r1.

SELECTION-SCREEN END OF BLOCK b2.



SELECTION-SCREEN BEGIN OF BLOCK b3 WITH FRAME.

  PARAMETERS: p_ch1 AS CHECKBOX DEFAULT 'X'. "##(## ####) ##

SELECTION-SCREEN END OF BLOCK b3.