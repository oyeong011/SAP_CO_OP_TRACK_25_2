
*&---------------------------------------------------------------------*

*&  Include           ZWORK05_001_SCR

*&---------------------------------------------------------------------*




SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME.

  PARAMETERS: P_DATE TYPE SY-DATUM.

  PARAMETERS: P_FNAME TYPE RLGRAP-FILENAME DEFAULT 'C:\Users\USER\Desktop\SAP\##\ex.xlsx'.

  PARAMETERS: P_TYPE(1) DEFAULT 'M'.

SELECTION-SCREEN END OF BLOCK B1.



AT SELECTION-SCREEN.

  PERFORM PRESS_FUNCTION_KEY.