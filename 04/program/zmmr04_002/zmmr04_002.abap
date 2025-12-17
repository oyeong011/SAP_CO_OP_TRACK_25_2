
*&---------------------------------------------------------------------*

*& Report ZMMR04_002

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZMMR04_002 MESSAGE-ID ZMED04.



include
ZMMR04_002_CLS
.

include
ZMMR04_002_TOP
.

include
ZMMR04_002_SCR
.

include
ZMMR04_002_F01
.

include
ZMMR04_002_PBO
.

include
ZMMR04_002_PAI
.



INITIALIZATION.

  PERFORM SET_INIT.



AT SELECTION-SCREEN OUTPUT.

  PERFORM SET_SCREEN.



START-OF-SELECTION.

  PERFORM CHECK_MANDATORY.



  IF P_RD1 = 'X'.   " ##

    PERFORM CHECK_VENDOR_EXIST.

    CALL SCREEN 100.

  ELSE.             " ##

    PERFORM SELECT_DATA.

    IF GT_PO[] IS NOT INITIAL.

      CALL SCREEN 200.

    ELSE.

      MESSAGE I001.

      EXIT.

    ENDIF.

  ENDIF.






*GUI Texts

*----------------------------------------------------------

* T100 --> #### ##

* T200 --> #### ## ##





*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   ##### ## #####.