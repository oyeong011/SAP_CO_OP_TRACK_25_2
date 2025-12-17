
*&---------------------------------------------------------------------*

*& Report ZWORK01_001

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZWORK01_001.



include
ZWORK01_001_CLS
.

include
ZWORK01_001_TOP
.

include
ZWORK01_001_SCR
.

include
ZWORK01_001_F01
.

include
ZWORK01_001_PBO
.

include
ZWORK01_001_PAI
.



AT SELECTION-SCREEN ON VALUE-REQUEST FOR P_FILE. "F4#### #### ## ##

  PERFORM GET_FILENAME. "#### ### P_FILE# ##



INITIALIZATION.

  PERFORM INIT_DATA.

AT SELECTION-SCREEN.

  PERFORM SET_SCREEN.

START-OF-SELECTION.

  PERFORM MAIN.






*GUI Texts

*----------------------------------------------------------

* T100 --> ## ####





*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   ##### ######.