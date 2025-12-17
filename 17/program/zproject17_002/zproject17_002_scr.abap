
*&---------------------------------------------------------------------*

*&  Include           ZPROJECT17_002_SCR

*&---------------------------------------------------------------------*






" #### ### ## ##

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE text-t01.

PARAMETERS: p_bukrs TYPE ekko-bukrs MODIF ID c1,   " ####

            p_lifnr TYPE ekko-lifnr MODIF ID c1,   " ###

            p_bedat TYPE ekko-bedat MODIF ID c1.   " ###(####)

SELECTION-SCREEN END OF BLOCK b1.





" PO ### ## ##

SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME TITLE text-t02.

PARAMETERS: p_lif_q TYPE ekko-lifnr MODIF ID c2, " #####

            p_bukr_q TYPE ekko-bukrs MODIF ID c2, " ####

            p_ebeln   TYPE ekko-ebeln MODIF ID c2. " PO##

SELECTION-SCREEN END OF BLOCK b2.





" #### ## : #### ## / PO ##

SELECTION-SCREEN BEGIN OF BLOCK b0 WITH FRAME TITLE text-t03.

PARAMETERS: p_cre  RADIOBUTTON GROUP r1 DEFAULT 'X' USER-COMMAND uc1, " #### ##

            p_disp RADIOBUTTON GROUP r1.                               " PO ##

SELECTION-SCREEN END OF BLOCK b0.