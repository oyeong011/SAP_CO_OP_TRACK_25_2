
*&---------------------------------------------------------------------*

*& Report ZMMR04_004

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZMMR04_004 MESSAGE-ID ZMED04.



include
ZMMR04_004_CLS
.

include
ZMMR04_004_TOP
.

include
ZMMR04_004_SCR
.

include
ZMMR04_004_F01
.

include
ZMMR04_004_PBO
.

include
ZMMR04_004_PAI
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

    PERFORM SELECT_INVOICE.

    IF GT_INVOICE[] IS NOT INITIAL.

      CALL SCREEN 200.

    ELSE.

      MESSAGE I001.

      EXIT.

    ENDIF.

  ENDIF.






*GUI Texts

*----------------------------------------------------------

* T100 --> ## ##

* T200 --> ## ##





*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   ### ### ######.