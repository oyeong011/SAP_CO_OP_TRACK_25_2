
*&---------------------------------------------------------------------*

*&  Include           ZPROJECT17_003_SCR

*&---------------------------------------------------------------------*






"--------------------------------------------------------------

" ## ## ## (#### / ### / #####)

"    - PO, ### : ####/## ##

"    - ##### : #### ##### ### (MODIF ID 'C1')

"--------------------------------------------------------------

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE text-t01.

" ####(##):ekko-ebeln, ###(##):zmara17-zwerks, #####(#####)(##)

PARAMETERS: p_ebeln TYPE zedt17_ekko-ebeln,   " ######

            p_werks TYPE zedt17_ekpo-zwerks,  " ###

            p_budat TYPE zedt17_mkpf-budat MODIF ID c1.  " #####(####)



SELECTION-SCREEN END OF BLOCK b1.



"--------------------------------------------------------------

" #### ## : #### / ####

"--------------------------------------------------------------

SELECTION-SCREEN BEGIN OF BLOCK b0 WITH FRAME TITLE text-t03.

" ####(##):ekko-ebeln, ###(##):zmara17-zwerks

PARAMETERS: p_r_cre RADIOBUTTON GROUP r1 DEFAULT 'X' USER-COMMAND uc1, " ####

            p_r_dis RADIOBUTTON GROUP r1.                              " ####



SELECTION-SCREEN END OF BLOCK b0.