
*&---------------------------------------------------------------------*

*& Report ZWORK06_002

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZWORK06_002.



include
ZWORK06_002_CLS
.  "### ##

include
ZWORK06_002_TOP
.  "## ##/## ###

include
ZWORK06_002_SCR
.  "Selection Screen

include
ZWORK06_002_F01
.  "FORM ##

include
ZWORK06_002_PBO
.  "PBO ##

include
ZWORK06_002_PAI
.  "PAI ##



"## ##

INITIALIZATION.



"## ## ##

START-OF-SELECTION.

  PERFORM GET_DATA.     "### ##

  PERFORM MODIFY_DATA.  "### ##

  CALL SCREEN 100.      "## ##








*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   ## ### #######.