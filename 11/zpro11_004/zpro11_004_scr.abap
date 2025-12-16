
*&---------------------------------------------------------------------*

*&  Include           ZPRO11_004_SCR

*&---------------------------------------------------------------------*

*& #### ##

*&---------------------------------------------------------------------*






" ## ## #### ##

SELECTION-SCREEN BEGIN OF BLOCK blk1 WITH FRAME TITLE TEXT-b01.

  PARAMETERS : p_ponum TYPE zpro11_009-ebeln MODIF ID inp. "######

  PARAMETERS : p_plant TYPE zpro11_009-werks MODIF ID inp. "###

  PARAMETERS : p_docdt TYPE sy-datum MODIF ID prc.         "#####

SELECTION-SCREEN END OF BLOCK blk1.



" #### ## ##

SELECTION-SCREEN BEGIN OF BLOCK blk2 WITH FRAME TITLE TEXT-b02.

  SELECTION-SCREEN BEGIN OF LINE.

    PARAMETERS : p_proc RADIOBUTTON GROUP rg1 DEFAULT 'X' USER-COMMAND mode.

    SELECTION-SCREEN COMMENT 4(10) lbl_proc FOR FIELD p_proc.

    PARAMETERS : p_disp RADIOBUTTON GROUP rg1.

    SELECTION-SCREEN COMMENT 19(10) lbl_disp FOR FIELD p_disp.

  SELECTION-SCREEN END OF LINE.

SELECTION-SCREEN END OF BLOCK blk2.






*----------------------------------------------------------------------*

* ### ## ## (SE38 > Goto > Text Elements## ## ## ## ##)

*----------------------------------------------------------------------*

* Selection Texts:

*   P_PONUM  = ####

*   P_PLANT  = ###

*   P_DOCDT  = ## ####

*   P_PROC   = ####

*   P_DISP   = ####

*

* Text Symbols:

*   B01 = ####

*   B02 = ####

*----------------------------------------------------------------------*