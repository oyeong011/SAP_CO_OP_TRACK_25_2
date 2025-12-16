
*&---------------------------------------------------------------------*

*&  Include           ZMM11_001_SCR

*&---------------------------------------------------------------------*




SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME.

  PARAMETERS : p_lifnr TYPE zpro11_002-lifnr MODIF ID m1. "#####

  PARAMETERS : p_bukrs TYPE zpro11_002-bukrs MODIF ID all. "####

  PARAMETERS : p_ktokk TYPE zpro11_001-ktokk MODIF ID m2. "#####



SELECTION-SCREEN END OF BLOCK b1.



SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME.

  SELECTION-SCREEN BEGIN OF LINE.



  PARAMETERS : p_rad1 RADIOBUTTON GROUP rb1 DEFAULT 'X' USER-COMMAND uc1. "##

  SELECTION-SCREEN COMMENT (10) FOR FIELD p_rad1.



  PARAMETERS : p_rad2 RADIOBUTTON GROUP rb1. "##

  SELECTION-SCREEN COMMENT (10) FOR FIELD p_rad2.

  SELECTION-SCREEN END OF LINE.



SELECTION-SCREEN END OF BLOCK b2.