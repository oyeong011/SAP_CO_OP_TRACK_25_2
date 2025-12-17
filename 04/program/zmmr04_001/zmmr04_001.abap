
*&---------------------------------------------------------------------*

*& Report ZMMR04_001

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZMMR04_001 MESSAGE-ID ZMED04.



include
ZMMR04_001_CLS
.

include
ZMMR04_001_TOP
.

include
ZMMR04_001_SCR
.

include
ZMMR04_001_F01
.

include
ZMMR04_001_PBO
.

include
ZMMR04_001_PAI
.






*INITIALIZATION.

*  SY-TITLE = '### ##/## ## ##'.






AT SELECTION-SCREEN OUTPUT.

  PERFORM SET_SCREEN.



START-OF-SELECTION.

  PERFORM CHECK_MANDATORY.



  IF P_RD1 = 'X'.   " ##

    CALL SCREEN 100.

  ELSE.             " ##

    PERFORM SELECT_DATA.

    IF GT_VENDOR_ALV[] IS NOT INITIAL.

      CALL SCREEN 200.

    ELSE.

      MESSAGE I001.

      EXIT.

    ENDIF.

  ENDIF.






*GUI Texts

*----------------------------------------------------------

* T100 --> ### ##

* T200 --> ### ## : ## ##





*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   ####