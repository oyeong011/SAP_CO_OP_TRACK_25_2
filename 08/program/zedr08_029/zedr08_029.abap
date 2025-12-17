
*&---------------------------------------------------------------------*

*& Report ZEDR08_029

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR08_029.



include
ZDOCKING_CONTAINER08_02_CLS
.

include
ZDOCKING_CONTAINER08_02_TOP
.

include
ZDOCKING_CONTAINER08_02_SCR
.

include
ZDOCKING_CONTAINER08_02_F01
.

include
ZDOCKING_CONTAINER08_02_PBO01
.

include
ZDOCKING_CONTAINER08_02_PAI01
.



INITIALIZATION.

  PERFORM SET_INIT.



START-OF-SELECTION.

  IF S_ZCODE IS INITIAL.

    EXIT.

  ENDIF.



  PERFORM GET_DATA.



  IF GT_STUDENT[] IS NOT INITIAL.

    CALL SCREEN 100.

  ELSE.

    EXIT.

  ENDIF.








*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   ##########