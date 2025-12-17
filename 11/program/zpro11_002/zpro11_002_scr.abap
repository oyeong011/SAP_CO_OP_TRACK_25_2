
*&---------------------------------------------------------------------*

*&  Include           ZPRO11_002_SCR

*&---------------------------------------------------------------------*




SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME.

  PARAMETERS : p_bukrs TYPE zpro11_004-bukrs MODIF ID all. "####

  PARAMETERS : p_lifnr TYPE zpro11_004-lifnr MODIF ID all. "###

  PARAMETERS : p_bedat TYPE zpro11_004-bedat MODIF ID m1.  "###

  PARAMETERS : p_ebeln TYPE zpro11_005-ebeln MODIF ID m2.  "######

SELECTION-SCREEN END OF BLOCK b1.



SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME.

  SELECTION-SCREEN BEGIN OF LINE.

    PARAMETERS : p_rad1 RADIOBUTTON GROUP rb1 DEFAULT 'X' USER-COMMAND uc1. "##

    SELECTION-SCREEN COMMENT (10) FOR FIELD p_rad1.

    PARAMETERS : p_rad2 RADIOBUTTON GROUP rb1. "##

    SELECTION-SCREEN COMMENT (10) FOR FIELD p_rad2.

  SELECTION-SCREEN END OF LINE.

SELECTION-SCREEN END OF BLOCK b2.