
*&---------------------------------------------------------------------*

*&  Include           ZPROJECT19_001_SCR

*&---------------------------------------------------------------------*






SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME TITLE TEXT-001.

  PARAMETERS : p_lifnr TYPE zpdt19_003-lifnr OBLIGATORY MATCHCODE OBJECT zsh_zpdt19_lifnr MODIF ID m1, "#####

               p_bukrs TYPE zpdt19_002-bukrs OBLIGATORY MODIF ID all,

               p_ktokk TYPE zpdt19_001-zktokk OBLIGATORY MODIF ID m2. "#####

SELECTION-SCREEN END OF BLOCK B1.



SELECTION-SCREEN SKIP 1. "# # ###



SELECTION-SCREEN BEGIN OF BLOCK B2 WITH FRAME.

  SELECTION-SCREEN BEGIN OF LINE.



  PARAMETERS : p_rad1 RADIOBUTTON GROUP rb1 DEFAULT 'X' USER-COMMAND uc1. "##

  SELECTION-SCREEN COMMENT (10) FOR FIELD p_rad1.



  PARAMETERS : p_rad2 RADIOBUTTON GROUP rb1. "##

  SELECTION-SCREEN COMMENT (10) FOR FIELD p_rad2.

  SELECTION-SCREEN END OF LINE.

SELECTION-SCREEN END OF BLOCK B2.