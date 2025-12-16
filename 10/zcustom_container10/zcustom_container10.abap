
*&---------------------------------------------------------------------*

*& Report ZCUSTOM_CONTAINER10

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZCUSTOM_CONTAINER10 MESSAGE-ID ZME10.



include
ZCUSTOM_CONTAINER10_TOP
.

include
ZCUSTOM_CONTAINER10_SCR
.

include
ZCUSTOM_CONTAINER10_F01
.

include
ZCUSTOM_CONTAINER10_PBO
.

include
ZCUSTOM_CONTAINER10_PAI
.



INITIALIZATION.

  PERFORM SET_INITIAL.



AT SELECTION-SCREEN OUTPUT.

  PERFORM SET_SCREEN.



START-OF-SELECTION.

  PERFORM GET_DATA.

  PERFORM MODIFY_DATA.

  IF GT_STUDENT[] IS NOT INITIAL.

    CALL SCREEN 100.

  ELSE.

    MESSAGE I000.

    EXIT.

  ENDIF.






*GUI Texts

*----------------------------------------------------------

* T100 --> ###