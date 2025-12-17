
*&---------------------------------------------------------------------*

*&  Include           ZMM22_003_SCR

*&---------------------------------------------------------------------*




SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME.

  "#### ##

  PARAMETERS : P_EBELN LIKE ZMSEG_22-EBELN MODIF ID GR,   "####

               P_WERKS LIKE ZMSEG_22-ZWERKS MODIF ID GR,  "###

               P_DATE  LIKE SY-DATUM        MODIF ID GR.  "## ###



  "#### ##

  PARAMETERS : P_EBELN2 LIKE ZMSEG_22-EBELN MODIF ID GS,  "####

               P_WERKS2 LIKE ZMSEG_22-ZWERKS MODIF ID GS. "###



  SELECTION-SCREEN SKIP.



  PARAMETERS : GR_RAD RADIOBUTTON GROUP R1 DEFAULT 'X' USER-COMMAND UC1.

  PARAMETERS : GS_RAD RADIOBUTTON GROUP R1.

SELECTION-SCREEN END OF BLOCK B1.