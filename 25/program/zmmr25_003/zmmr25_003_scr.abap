
*&---------------------------------------------------------------------*

*&  Include           ZMMR25_003_SCR

*&---------------------------------------------------------------------*






SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME TITLE TEXT-001.

  " 1. #### ## ##

  " ZMSEG# EBELN ### #### #### ##

  PARAMETERS : P_EBELN LIKE ZEDT25_ZMSEG-EBELN MODIF ID CR1, "####

               P_WERKS LIKE ZEDT25_ZMSEG-ZWERKS MODIF ID CR1, "### (ZWERKS ##)

               P_DATE  LIKE SY-DATUM MODIF ID CR1.         "#####



  " 2. #### ## ##

  PARAMETERS : P_EBELN2 LIKE ZEDT25_ZMSEG-EBELN MODIF ID DSP, "####

               P_WERKS2 TYPE ZEDT25_ZMSEG-ZWERKS MODIF ID DSP. "###



  SELECTION-SCREEN SKIP 1. " # # ###



  " 3. #### OR #### ##

  PARAMETERS : RB_CR  RADIOBUTTON GROUP GRP1 DEFAULT 'X' USER-COMMAND UCOM. "####

  PARAMETERS : RB_DSP RADIOBUTTON GROUP GRP1. "####

SELECTION-SCREEN END OF BLOCK B1.