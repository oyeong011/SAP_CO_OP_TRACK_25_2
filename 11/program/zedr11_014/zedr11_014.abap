
*&---------------------------------------------------------------------*

*& Report ZEDR11_014

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR11_014.



include
ZEDR11_014_TOP
.

include
ZEDR11_014_SCR
.

include
ZEDR11_014_F01
.

include
ZEDR11_014_PBO
.

include
ZEDR11_014_PAI
.





INITIALIZATION.

  PERFORM set_init.



START-OF-SELECTION.

  PERFORM get_data.



  CALL SCREEN 100.