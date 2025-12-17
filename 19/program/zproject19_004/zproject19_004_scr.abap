
*&---------------------------------------------------------------------*

*&  Include           ZPROJECT19_004_SCR

*&---------------------------------------------------------------------*




SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME TITLE TEXT-001.



  PARAMETERS : p_ebeln TYPE ebeln OBLIGATORY MATCHCODE OBJECT zsh_zpdt19_ebeln MODIF ID all, "####

               p_werks TYPE zwerks19 OBLIGATORY MODIF ID all,

               p_date TYPE bldat OBLIGATORY MODIF ID cr1.



SELECTION-SCREEN END OF BLOCK B1.



SELECTION-SCREEN SKIP 1.



SELECTION-SCREEN BEGIN OF BLOCK B2 WITH FRAME.

  PARAMETERS : RB_CR RADIOBUTTON GROUP GRP1 DEFAULT 'X' USER-COMMAND UCOM.

  PARAMETERS : RB_DSP RADIOBUTTON GROUP GRP1.

SELECTION-SCREEN END OF BLOCK B2.