
*&---------------------------------------------------------------------*

*& Report ZMMR04_003

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZMMR04_003 MESSAGE-ID ZMED04.



include
ZMMR04_003_CLS
.

include
ZMMR04_003_TOP
.

include
ZMMR04_003_SCR
.

include
ZMMR04_003_F01
.

include
ZMMR04_003_PBO
.

include
ZMMR04_003_PAI
.



INITIALIZATION.

  PERFORM SET_INIT.



AT SELECTION-SCREEN OUTPUT.

  PERFORM SET_SCREEN.



START-OF-SELECTION.

  PERFORM CHECK_MANDATORY.



  IF P_RD1 = 'X'. " ####

    PERFORM CHECK_PO_EXIST.

    PERFORM SELECT_PO_DATA.

    IF GT_PO[] IS NOT INITIAL.

      CALL SCREEN 100.

    ELSE.

      MESSAGE I001.

      EXIT.

    ENDIF.

  ELSE.           " ####

    PERFORM SELECT_RG_DATA.

    IF GT_RG[] IS NOT INITIAL.

      CALL SCREEN 200.

    ELSE.

      MESSAGE I001.

      EXIT.

    ENDIF.

  ENDIF.






*GUI Texts

*----------------------------------------------------------

* T100 --> ## ##

* T200 --> ## ## ##





*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   ##### #### ####.