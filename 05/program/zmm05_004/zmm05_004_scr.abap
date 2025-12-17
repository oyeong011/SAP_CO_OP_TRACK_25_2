
*&---------------------------------------------------------------------*

*&  Include           ZMM05_004_SCR

*&---------------------------------------------------------------------*






SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME.

  PARAMETERS: P_EBELN TYPE ZMSEG_05-EBELN.   " ####

  PARAMETERS: P_WERKS TYPE ZMSEG_05-ZWERKS.   " ###

  PARAMETERS: P_DATE TYPE ZMKPF_05-BLDAT MODIF ID M1.   " #####

SELECTION-SCREEN END OF BLOCK B1.



SELECTION-SCREEN BEGIN OF BLOCK B2 WITH FRAME.

  SELECTION-SCREEN BEGIN OF LINE.

    " 1. # ## ### ##

    PARAMETERS : P_R1 RADIOBUTTON GROUP R1 DEFAULT 'X' USER-COMMAND UC1.

    " 1-1. ## ## ### ### (TEXT-001 ##)

    SELECTION-SCREEN COMMENT (10) TEXT-001 FOR FIELD P_R1.



    " 2. ## ### (## ##)

    SELECTION-SCREEN POSITION 30.



    " 3. # ## ### ##

    PARAMETERS : P_R2 RADIOBUTTON GROUP R1.

    " 3-1. ## ## ### ### (TEXT-002 ##)

    SELECTION-SCREEN COMMENT (10) TEXT-002 FOR FIELD P_R2.

  SELECTION-SCREEN END OF LINE.

SELECTION-SCREEN END OF BLOCK B2.