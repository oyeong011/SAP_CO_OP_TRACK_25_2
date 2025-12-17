
*&---------------------------------------------------------------------*

*&  Include           ZWORK17_002_SCR

*&---------------------------------------------------------------------*




SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-t01.

PARAMETERS: p_date TYPE sy-datum OBLIGATORY.   " ####

SELECTION-SCREEN END OF BLOCK b1.



INITIALIZATION.

  p_date = sy-datum.