
*&---------------------------------------------------------------------*

*& Report ZWORK25_002

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZWORK25_002.



include
ZWORK25_002_TOP
.

include
ZWORK25_002_SCR
.

include
ZWORK25_002_F01
.

include
ZWORK25_002_PBO
.

include
ZWORK25_002_PAI
.



INITIALIZATION.



AT SELECTION-SCREEN OUTPUT.



START-OF-SELECTION.

  PERFORM CHECK_DATA.

  PERFORM GET_DATA.



  CALL SCREEN 100.



END-OF-SELECTION.






*GUI Texts

*----------------------------------------------------------

* T100 --> ## #### # ##





*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   ## ### #####.