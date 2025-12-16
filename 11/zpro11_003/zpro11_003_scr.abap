
*&---------------------------------------------------------------------*

*&  Include           ZPRO11_003_SCR

*&---------------------------------------------------------------------*

*& #### ##

*&---------------------------------------------------------------------*






SELECTION-SCREEN BEGIN OF BLOCK blk1 WITH FRAME TITLE TEXT-001.

  PARAMETERS : p_ponum TYPE zpro11_007-ebeln MODIF ID all.

  PARAMETERS : p_plant TYPE zpro11_007-werks MODIF ID all.

  PARAMETERS : p_grdat TYPE sy-datum MODIF ID prc.

SELECTION-SCREEN END OF BLOCK blk1.



SELECTION-SCREEN BEGIN OF BLOCK blk2 WITH FRAME TITLE TEXT-002.

  SELECTION-SCREEN BEGIN OF LINE.

    PARAMETERS : p_proc RADIOBUTTON GROUP rg1 DEFAULT 'X' USER-COMMAND cmd1.

    SELECTION-SCREEN COMMENT (10) txt_prc FOR FIELD p_proc.

    PARAMETERS : p_disp RADIOBUTTON GROUP rg1.

    SELECTION-SCREEN COMMENT (10) txt_dsp FOR FIELD p_disp.

  SELECTION-SCREEN END OF LINE.

SELECTION-SCREEN END OF BLOCK blk2.