
*&---------------------------------------------------------------------*

*& Report ZEDR23_017

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR23_017.



include
ZEDR23_017_TOP
.

include
ZEDR23_017_SCR
.

include
ZEDR23_017_F01
.

include
ZEDR23_017_PBO
. " Process Before Output

include
ZEDR23_017_PAI
. " Process After Input



INITIALIZATION.

PERFORM SET_INIT.



START-OF-SELECTION.

PERFORM GET_DATA.



CALL SCREEN 100.






*GUI Texts

*----------------------------------------------------------

* T100 --> #####