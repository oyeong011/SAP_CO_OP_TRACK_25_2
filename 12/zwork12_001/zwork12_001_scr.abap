
*&---------------------------------------------------------------------*

*&  Include           ZWORK12_001_SCR

*&---------------------------------------------------------------------*




SELECTION-SCREEN FUNCTION KEY 1. "## 1###.

SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME.

  PARAMETERS: P_DATE TYPE D DEFAULT SY-DATUM.



  "#### ### ##### ## #### ##

  PARAMETERS: P_FILE TYPE RLGRAP-FILENAME. " For application server files



  "## ## M## ##

  PARAMETERS: P_KURST TYPE KURST DEFAULT 'M' MODIF ID M1 VISIBLE LENGTH 1.

SELECTION-SCREEN END OF BLOCK B1.