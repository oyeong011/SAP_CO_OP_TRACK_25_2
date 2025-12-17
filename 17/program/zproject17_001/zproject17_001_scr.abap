
*&---------------------------------------------------------------------*

*&  Include           ZPROJECT17_001_SCR

*&---------------------------------------------------------------------*






" ### ### ## ##

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME.

PARAMETERS: p_bukrs TYPE zedt17_lfb1-bukrs MODIF ID c1, " ####

            p_ktokk TYPE zedt17_lfa1-ktokk MODIF ID c1. " #####

SELECTION-SCREEN END OF BLOCK b1.



" ### ### ## ##

SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME.

PARAMETERS: p_lifnr TYPE zedt17_lfa1-lifnr MODIF ID c2, " #####

            p_qbuk  TYPE zedt17_lfb1-bukrs MODIF ID c2. " ####(###)

SELECTION-SCREEN END OF BLOCK b2.





" #### ## : ### ## / ### ##

SELECTION-SCREEN BEGIN OF BLOCK b0 WITH FRAME.

PARAMETERS: p_cre  RADIOBUTTON GROUP r1 DEFAULT 'X' USER-COMMAND uc1, " ### ##

            p_disp RADIOBUTTON GROUP r1.                               " ### ##

SELECTION-SCREEN END OF BLOCK b0.