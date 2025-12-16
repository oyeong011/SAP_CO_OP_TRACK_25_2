
*&---------------------------------------------------------------------*

*& Report ZWORK13_002

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZWORK13_002 MESSAGE-ID ZMED13.






*INCLUDE ZWORK13_002_CLS.




include
ZWORK13_002_TOP
.

include
ZWORK13_002_SCR
.

include
ZWORK13_002_F01
.

include
ZWORK13_002_O01
.

include
ZWORK13_002_I01
.



START-OF-SELECTION.

  IF P_DATE IS INITIAL.

    MESSAGE I000.

    EXIT.

  ENDIF.

  PERFORM GET_DATE.

  CALL SCREEN 100.






*GUI Texts

*----------------------------------------------------------

* T001 --> ## ####





*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   #######