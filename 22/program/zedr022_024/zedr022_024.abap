
*&---------------------------------------------------------------------*

*& Report ZEDR022_024

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR022_024.



include
ZCLASS_EVENT22_CLS
.

include
ZCLASS_EVENT22_TOP
.

include
ZCLASS_EVENT22_SCR
.

include
ZCLASS_EVENT22_F01
.

include
ZCLASS_EVENT22_O01
.

include
ZCLASS_EVENT22_I01
.



INITIALIZATION.

  PERFORM SET_INIT.



START-OF-SELECTION.

  "IF S_ZCODE IS INITIAL.

    "MESSAGE I000.

    "EXIT.

  "ENDIF.

  PERFORM GET_DATA.



  "IF GT_STUDENT[] IS NOT INITIAL.

    CALL SCREEN 100.






*GUI Texts

*----------------------------------------------------------

* T100 --> #####





*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   ##########