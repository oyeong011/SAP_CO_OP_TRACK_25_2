
*&---------------------------------------------------------------------*

*&  Include           ZPROJECT17_004_SCR

*&---------------------------------------------------------------------*






"--------------------------------------------------------------

" ## ## ## (#### / ### / #### / #####)

"  - #####(P_BUDAT)# '####' ##### ### (MODIF ID C1)

"  - OBLIGATORY# #### ##, F8 ## # check_selection## ##

"--------------------------------------------------------------

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE text-t01.



PARAMETERS: p_ebeln TYPE zedt17_ekko-ebeln,    " ####

            p_werks TYPE zedt17_ekpo-zwerks,   " ###

            p_budat TYPE zedt17_rbkp-budat MODIF ID c1.  " #####(###)



SELECTION-SCREEN END OF BLOCK b1.



"--------------------------------------------------------------

" #### ## : #### / ####

"  - USER-COMMAND# ### ## # AT SELECTION-SCREEN OUTPUT ##

"--------------------------------------------------------------

SELECTION-SCREEN BEGIN OF BLOCK b0 WITH FRAME TITLE text-t03.



PARAMETERS: p_r_cre RADIOBUTTON GROUP r1 DEFAULT 'X' USER-COMMAND uc1, " ####

            p_r_dis RADIOBUTTON GROUP r1.                              " ####



SELECTION-SCREEN END OF BLOCK b0.