
*&---------------------------------------------------------------------*

*& Report ZEDR018_021

*&---------------------------------------------------------------------*

*& 2025-11-06

*&---------------------------------------------------------------------*




REPORT ZEDR018_021 MESSAGE-ID ZMED18.



include
ZCLASS_EVENT18_CLS
.

include
ZCLASS_EVENT18_TOP
.

include
ZCLASS_EVENT18_SCR
.

include
ZCLASS_EVENT18_F01
.

include
ZCLASS_EVENT18_O01
.

include
ZCLASS_EVENT18_I01
.



INITIALIZATION.

  PERFORM SET_INIT.



START-OF-SELECTION.

  IF S_ZCODE IS INITIAL.

    IF P_ZPERNR IS INITIAL.

      MESSAGE I000.

      EXIT.

    ENDIF.

  ENDIF.

  PERFORM GET_DATA.



  IF GT_STUDENT[] IS NOT INITIAL.

    CALL SCREEN 100.

  ELSE.

    MESSAGE I000.

    EXIT.

  ENDIF.






*GUI Texts

*----------------------------------------------------------

* T100 --> CLASS EVENT





*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   ##########