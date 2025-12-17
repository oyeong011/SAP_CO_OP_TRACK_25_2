
*&---------------------------------------------------------------------*

*& Report ZWORK21_002

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZWORK21_002 MESSAGE-ID ZMED21.



include
ZWORK21_002_TOP
.

include
ZWORK21_002_SCR
.

include
ZWORK21_002_F01
.

include
ZWORK21_002_PBO
.

include
ZWORK21_002_PAI
.



"SELECTION-SCREEN ###

INITIALIZATION.



  AT SELECTION-SCREEN OUTPUT.

    PERFORM SET_INITIAL.



  START-OF-SELECTION.

    PERFORM GET_DATA.

    CALL SCREEN 100.






*GUI Texts

*----------------------------------------------------------

* SEARCH --> ####





*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   SMW0 #### ## # ####.