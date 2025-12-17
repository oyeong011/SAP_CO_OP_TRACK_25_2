
*&---------------------------------------------------------------------*

*& Report ZCLASS_EVENT10

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZCLASS_EVENT10 MESSAGE-ID ZEDM10.



include
ZCLASS_EVENT10_CLS
.

include
ZCLASS_EVENT10_TOP
.

include
ZCLASS_EVENT10_SCR
.

include
ZCLASS_EVENT10_F01
.

include
ZCLASS_EVENT10_O01
.

include
ZCLASS_EVENT10_I01
.



INITIALIZATION.

  PERFORM SET_INIT.



START-OF-SELECTION.

  IF S_ZCODE IS INITIAL.

    MESSAGE I000.

    EXIT.

  ENDIF.



  PERFORM GET_DATA.



END-OF-SELECTION.

  CALL SCREEN 100.






*GUI Texts

*----------------------------------------------------------

* T100 --> EVENT





*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   #######