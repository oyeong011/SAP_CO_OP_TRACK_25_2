
*&---------------------------------------------------------------------*

*& Report ZEDR14_029

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR14_029 MESSAGE-ID ZMED14.



"ZCLASS EVENT ##



include
ZEDR14_029_CLS
.

include
ZEDR14_029_TOP
.

include
ZEDR14_029_SCR
.

include
ZEDR14_029_F01
.

include
ZEDR14_029_O01
.

include
ZEDR14_029_I01
.



INITIALIZATION.

  PERFORM SET_INIT.



START-OF-SELECTION.

  IF S_ZCODE IS INITIAL.

    MESSAGE I000.

    EXIT.

  ENDIF.

  PERFORM GET_DATA.



  CALL SCREEN 100.








*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   ##########