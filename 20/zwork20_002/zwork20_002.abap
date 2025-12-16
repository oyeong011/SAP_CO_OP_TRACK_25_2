
*&---------------------------------------------------------------------*

*& Report ZWORK20_002

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZWORK20_002.



include
ZWORK20_002_CLS
.

include
ZWORK20_002_TOP
.

include
ZWORK20_002_SCR
.

include
ZWORK20_002_F01
.

include
ZWORK20_002_PBO
.

include
ZWORK20_002_PAI
.



INITIALIZATION.

  PERFORM SET_DEFAULT.



START-OF-SELECTION.

  PERFORM GET_DATA.

  PERFORM MODIFY_DATA.



  CALL SCREEN 100.






*GUI Texts

*----------------------------------------------------------

* T100 --> ## ####





*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   ### ######.