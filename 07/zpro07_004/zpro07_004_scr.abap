
*&---------------------------------------------------------------------*

*&  Include           ZPRO07_004_SCR

*&---------------------------------------------------------------------*




SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME.

  PARAMETERS : p_ebeln TYPE zpro07_009-ebeln MODIF ID all. "####

  PARAMETERS : p_werks TYPE zpro07_009-werks MODIF ID all. "###

  PARAMETERS : p_indat TYPE sy-datum MODIF ID m1. "## ###

SELECTION-SCREEN END OF BLOCK b1.



SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME.

  SELECTION-SCREEN BEGIN OF LINE.



    PARAMETERS : p_rad1 RADIOBUTTON GROUP rb1 DEFAULT 'X' USER-COMMAND uc1. "####

    SELECTION-SCREEN COMMENT (10) FOR FIELD p_rad1.



    PARAMETERS : p_rad2 RADIOBUTTON GROUP rb1. "##

    SELECTION-SCREEN COMMENT (10) FOR FIELD p_rad2.

    SELECTION-SCREEN END OF LINE.



SELECTION-SCREEN END OF BLOCK b2.