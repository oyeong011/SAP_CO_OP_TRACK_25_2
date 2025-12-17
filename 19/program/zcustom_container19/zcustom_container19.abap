
*&---------------------------------------------------------------------*

*& Report ZCUSTOM_CONTAINER19

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZCUSTOM_CONTAINER19 MESSAGE-ID ZMED00.



include
ZCUSTOM_CONTAINER19_CLS
. "### TOP ## ##

include
ZCUSTOM_CONTAINER19_TOP
.

include
ZCUSTOM_CONTAINER19_SCR
.

include
ZCUSTOM_CONTAINER19_F01
.

include
ZCUSTOM_CONTAINER19_PBO
.

include
ZCUSTOM_CONTAINER19_PAI
.



INITIALIZATION.

  PERFORM SET_INITIALIZATION.



AT SELECTION-SCREEN OUTPUT.

  PERFORM SET_SCREEN.



START-OF-SELECTION.

  PERFORM GET_DATA.



  IF GT_STUDENT[] IS NOT INITIAL.

    CALL SCREEN 100. "CUSTOM CONTROL# #### ## # ##, CALL SCREEN ##

  ELSE.

    MESSAGE I000.

    EXIT.

  ENDIF.








*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   ##########