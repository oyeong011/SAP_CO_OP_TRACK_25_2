
*&---------------------------------------------------------------------*

*&  Include           ZPROJECT19_002_SCR

*&---------------------------------------------------------------------*






SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME TITLE TEXT-001.

  PARAMETERS : p_bukrs TYPE zpdt19_004-bukrs OBLIGATORY MODIF ID all, "####

               p_lifnr TYPE zpdt19_004-lifnr OBLIGATORY MATCHCODE OBJECT zsh_zpdt19_lifnr MODIF ID all, "###

               p_bedat TYPE zpdt19_004-bedat OBLIGATORY MODIF ID m1, "###

               p_ebeln TYPE zpdt19_004-ebeln OBLIGATORY MATCHCODE OBJECT zsh_zpdt19_ebeln MODIF ID m2. "######

SELECTION-SCREEN END OF BLOCK B1.





SELECTION-SCREEN SKIP 1. "# # ###



SELECTION-SCREEN BEGIN OF BLOCK B2 WITH FRAME.

  "##

  PARAMETERS : RB_CR RADIOBUTTON GROUP GRP1 DEFAULT 'X' USER-COMMAND UCOM.

  "##

  PARAMETERS : RB_DSP RADIOBUTTON GROUP GRP1.

SELECTION-SCREEN END OF BLOCK B2.