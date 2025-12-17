
*&---------------------------------------------------------------------*

*&  Include           ZEDR07_PRACTICE009_SCR

*&---------------------------------------------------------------------*




SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME.

  SELECT-OPTIONS : s_zemp FOR zedt07_102-zpernr.

  SELECT-OPTIONS : s_date FOR zedt07_102-datbi NO INTERVALS NO-EXTENSION.

  SELECT-OPTIONS : s_zdep FOR zedt07_104-zdepcode NO INTERVALS NO-EXTENSION.

SELECTION-SCREEN END OF BLOCK b1.



SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME.

  PARAMETERS : p_ch1 AS CHECKBOX DEFAULT 'X'.

SELECTION-SCREEN END OF BLOCK b2.