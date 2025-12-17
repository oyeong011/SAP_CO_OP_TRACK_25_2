
*&---------------------------------------------------------------------*

*& Report ZWORK02_002

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZWORK02_002 MESSAGE-ID ZMED02.



include
ZWORK02_002_TOP
.

include
ZWORK02_002_SCR
.

include
ZWORK02_002_F01
.

include
ZWORK02_002_PBO
.

include
ZWORK02_002_PAI
.



INITIALIZATION.

  PERFORM SET_INIT.



AT SELECTION-SCREEN OUTPUT.

  PERFORM SET_SCREEN.



AT SELECTION-SCREEN.

  PERFORM VALIDATE_INPUT.



START-OF-SELECTION.

  PERFORM GET_DATA.

  CALL SCREEN 100.






*GUI Texts

*----------------------------------------------------------

* T100 --> ## ####





*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   ## ### #######.