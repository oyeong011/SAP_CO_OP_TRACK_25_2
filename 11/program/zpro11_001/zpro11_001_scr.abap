
*&---------------------------------------------------------------------*

*&  Include           ZPRO11_001_SCR

*&---------------------------------------------------------------------*




SELECTION-SCREEN BEGIN OF BLOCK blk1 WITH FRAME.

  PARAMETERS : pa_lifnr TYPE zpro11_002-lifnr MODIF ID md1. "#####

  PARAMETERS : pa_bukrs TYPE zpro11_002-bukrs MODIF ID all. "####

  PARAMETERS : pa_ktokk TYPE zpro11_001-ktokk MODIF ID md2. "#####

SELECTION-SCREEN END OF BLOCK blk1.



SELECTION-SCREEN BEGIN OF BLOCK blk2 WITH FRAME.

  SELECTION-SCREEN BEGIN OF LINE.

  PARAMETERS : pa_rad1 RADIOBUTTON GROUP rg1 DEFAULT 'X' USER-COMMAND chg_mode. "##

  SELECTION-SCREEN COMMENT (10) FOR FIELD pa_rad1.

  PARAMETERS : pa_rad2 RADIOBUTTON GROUP rg1. "##

  SELECTION-SCREEN COMMENT (10) FOR FIELD pa_rad2.

  SELECTION-SCREEN END OF LINE.

SELECTION-SCREEN END OF BLOCK blk2.