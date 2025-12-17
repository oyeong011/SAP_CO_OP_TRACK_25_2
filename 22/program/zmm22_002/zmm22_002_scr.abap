
*&---------------------------------------------------------------------*

*&  Include           ZMM22_002_SCR

*&---------------------------------------------------------------------*

*---------------------------------------------------------------------*

*  SELECTION SCREEN

*---------------------------------------------------------------------*




SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME.

  PARAMETERS: P_BUKRS LIKE ZEKKO_22-BUKRS MODIF ID C,  " ####

              P_LIFNR LIKE ZEKKO_22-LIFNR MODIF ID C,  " ###

              P_BEDAT TYPE DATS           MODIF ID C.  " ###

SELECTION-SCREEN END OF BLOCK B1.



SELECTION-SCREEN BEGIN OF BLOCK B2 WITH FRAME.

  PARAMETERS: P_LIFN2 LIKE ZEKKO_22-LIFNR MODIF ID S,   " #####

              P_BUKR2 LIKE ZEKKO_22-BUKRS MODIF ID S,   " ####

              P_EBELN LIKE ZEKKO_22-EBELN MODIF ID S.   " PO ##

SELECTION-SCREEN END OF BLOCK B2.



PARAMETERS: P_CRE RADIOBUTTON GROUP R1 DEFAULT 'X' USER-COMMAND UC1,

            P_SEL RADIOBUTTON GROUP R1.