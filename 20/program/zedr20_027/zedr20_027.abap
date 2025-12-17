
*&---------------------------------------------------------------------*

*& Report ZEDR20_027

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR20_027.



include
ZEDR20_027_TOP
.

include
ZEDR20_027_SCR
.

include
ZEDR20_027_F01
.

include
ZEDR20_027_PBO
.

include
ZEDR20_027_PAI
.



INITIALIZATION.

  PERFORM SET_DEFAULT.



START-OF-SELECTION.

  PERFORM GET_DATA.



  CALL SCREEN 100.






*GUI Texts

*----------------------------------------------------------

* T100 --> DOCKING CONTAINER