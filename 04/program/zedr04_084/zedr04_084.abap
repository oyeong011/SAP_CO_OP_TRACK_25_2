
*&---------------------------------------------------------------------*

*& Report ZEDR04_084

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR04_084 MESSAGE-ID ZMED04.



" ##### CLASS ALV - DOCKING CONTAINER ## ##

include
ZEDR04_084_CLS
. " #### ##### ##

include
ZEDR04_084_TOP
.

include
ZEDR04_084_SCR
.

include
ZEDR04_084_F01
.

include
ZEDR04_084_PBO
.

include
ZEDR04_084_PAI
.



INITIALIZATION.

  PERFORM SET_INIT.



START-OF-SELECTION.

  IF S_ZCODE IS INITIAL.

    MESSAGE I000.

    EXIT.

  ENDIF.

  PERFORM SELECT_DATA.



  IF GT_STUDENT[] IS NOT INITIAL.

    CALL SCREEN 100.

  ELSE.

    MESSAGE I001.

    EXIT.

  ENDIF.






*GUI Texts

*----------------------------------------------------------

* T100 --> ## ## ###





*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   ##########