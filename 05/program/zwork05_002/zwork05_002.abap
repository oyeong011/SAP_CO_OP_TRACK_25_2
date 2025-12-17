
*&_____________________________________________________________________*

*& Report ZWORK05_002

*&_____________________________________________________________________*

*&

*&_____________________________________________________________________*




REPORT ZWORK05_002 MESSAGE-ID ZMED05.





include
ZWORK05_002_CLS
.

include
ZWORK05_002_TOP
.

include
ZWORK05_002_SCR
.

include
ZWORK05_002_F01
.

include
ZWORK05_002_PBO
.

include
ZWORK05_002_PAI
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

* 0100 --> 0100

* 0100 --> 0100





*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   ### #### ####.