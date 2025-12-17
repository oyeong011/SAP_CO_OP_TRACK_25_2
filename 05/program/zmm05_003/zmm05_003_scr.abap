
*&---------------------------------------------------------------------*

*&  Include           ZMM05_003_SCR

*&---------------------------------------------------------------------*






SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME TITLE TEXT-001.

  "1. ### ## ##

  " ZMSEG_05## EBELN ### #### ## ##

  PARAMETERS : P_EBELN LIKE ZMSEG_05-EBELN MODIF ID CR1, "####

               P_WERKS LIKE ZMSEG_05-ZWERKS MODIF ID CR1, "### (ZWERKS ##)

               P_DATE  LIKE SY-DATUM MODIF ID CR1.        "#####



  "2. ### ## ##

  PARAMETERS : P_EBELN2 LIKE ZMSEG_05-EBELN MODIF ID DSP, "####

               P_WERKS2 TYPE ZMSEG_05-ZWERKS MODIF ID DSP. "###



  SELECTION-SCREEN SKIP 1. "# # ###



  "3. ## OR ## ##

  PARAMETERS : RB_CR  RADIOBUTTON GROUP GRP1 DEFAULT 'X' USER-COMMAND UCOM. "##

  PARAMETERS : RB_DSP RADIOBUTTON GROUP GRP1. "##

SELECTION-SCREEN END OF BLOCK B1.