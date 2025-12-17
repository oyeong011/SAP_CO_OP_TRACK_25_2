
*&---------------------------------------------------------------------*

*& Report ZEDR24_025_USERCOMMAND

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR24_025_USERCOMMAND.



include
ZEDR24_025_USERCOMMAND_CLS
.

include
ZEDR24_025_USERCOMMAND_TOP
.

include
ZEDR24_025_USERCOMMAND_F01
.

include
ZEDR24_025_USERCOMMAND_PBO
.

include
ZEDR24_025_USERCOMMAND_PAI
.



INITIALIZATION.



START-OF-SELECTION.

  PERFORM GET_DATA.

  CALL SCREEN 100.








*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   ##########