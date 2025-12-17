
*&---------------------------------------------------------------------*

*&  Include           ZMM21_001_SCR

*&---------------------------------------------------------------------*




"=================================================

" ## ## (B1)

"=================================================

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME.

  PARAMETERS : P_LIFNR TYPE ZLFB1_21-LIFNR MODIF ID M1.   "#####

  PARAMETERS : P_BUKRS TYPE ZLFB1_21-BUKRS MODIF ID ALL.   "####

  PARAMETERS : P_KTOKK TYPE ZLFA1_21-KTOKK MODIF ID M2.   "### ##





SELECTION-SCREEN END OF BLOCK b1.





"=================================================

" ## ## (B2)

"=================================================

SELECTION-SCREEN BEGIN OF BLOCK B2 WITH FRAME.

  SELECTION-SCREEN BEGIN OF LINE.



    PARAMETERS : P_RAD1 RADIOBUTTON GROUP RB1 DEFAULT 'X' USER-COMMAND UC1. "##

    SELECTION-SCREEN COMMENT (10) FOR FIELD P_RAD1.



    PARAMETERS : P_RAD2 RADIOBUTTON GROUP RB1. "##

    SELECTION-SCREEN COMMENT (10) FOR FIELD P_RAD2.

    SELECTION-SCREEN END OF LINE.



  SELECTION-SCREEN END OF BLOCK B2.